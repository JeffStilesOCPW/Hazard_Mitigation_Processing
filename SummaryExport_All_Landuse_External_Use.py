import arcpy, requests, json, urllib, xlsxwriter, os, csv
from datetime import datetime
from collections import Counter


### Function to add count to variables for individual land use hazard totals ###
### changed "if value ==" to "if value in" to support list
def calcCountHazard(indic,landuseVal,hundo,hundoP,fiveHundo,landslide,fire,eq,prado,mhhw,CoastFlood):
    for key,value in indic.items():
        if value[0] in landuseVal and value[1] == '100':
            hundo += 1
        if value[0] in landuseVal and value[2] == '100':
            hundoP += 1
        if value[0] in landuseVal and value[3] == '500':
            fiveHundo += 1
        if value[0] in landuseVal and value[4] != '0':
            landslide += 1
        if value[0] in landuseVal and value[5] == 'Very High':
            fire += 1
        if value[0] in landuseVal and value[6] == 'MMI of 7 or Higher':
            eq += 1
        if value[0] in landuseVal and value[9] == 'Prado':
            prado += 1
        if value[0] in landuseVal and value[10] == 'YES':
            mhhw += 1
        if value[0] in landuseVal and value[11] == 'YES':
            CoastFlood += 1
    return [hundo, hundoP, fiveHundo, landslide, fire, eq, prado, mhhw, CoastFlood]

            
                     
            
### Identify SDE connection file to source Database ###
SDE = 'F:/PROJECTS/Jeff/Administration/ConnectionFiles/ADMIN_OC_Survey.sde'

### Identify feature class used to aggregate data after SQL intersects are run ### 
FC = SDE + '/HM_2020_LEGAL_LOTS_ALL_DATA'

### Chose to run exoport on entirety of dataset or a subset ###
### In the County's case this was run on either all parcels or unincorporated jurisdiction parcels ###
### For use in other jurisdictions the where clause will need to be adjusted from what is listed below ###
### Two sets of where clauses and output locations are listed below, one for each type of output required ###

whereclause = """ 1=1 """
#whereclause = """ WHERE CITY = 'Unincorporated' """.format(arcpy.AddFieldDelimiters(FC, 'CITY'))

workbook = xlsxwriter.Workbook('F:\PROJECTS\Jeff\Hazard_Mitigation_Planning\Output_Data_2020\HazardSummary_all_LU.xlsx')
#workbook = xlsxwriter.Workbook('F:\PROJECTS\Jeff\Hazard_Mitigation_Planning\Output_Data_2020\HazardSummaryUnincorporated_all_LU.xlsx')



### Landuse Value Lists SCAG Landuse Codes ###
GeneralOffice = [1210,1211,1212,1213]
CommercialServices = [1200,1220,1221,1222,1223,1230,1231,1232,1233]
Facilities = [1240,1241,1242,1243,1244,1245,1246,1247,1250,1251,1252,1253]
Education = [1260,1261,1262,1263,1264,1265,1266]
MilitaryInstallations = [1270,1271,1272,1273,1274,1275,1276]
Industrial = [1300,1310,1311,1312,1313,1314,1320,1321,1322,1323,1324,1325,1330,1331,1332,1340]
TransportationCommunicationsUtilities = [1400,1410,1411,1412,1413,1414,1415,1416,1417,1418,
                                         1420,1430,1431,1432,1433,1434,1435,1436,1437,1438,
                                         1440,1441,1442,1450,1460]
MixedCommercialIndustrial = [1500]
OpenSpaceRecreation = [1800,1810,1820,1830,1840,1850,1860,1870,1880,1890]
Agriculture = [2000,2100,2110,2120,2200,2300,2400,2500,2600,2700]
Vacant = [3000,3100,3200,3300,3400,1900]
Water = [4000,4100,4200,4300,4400,4500]
SpecificPlan = [7777]
UnderConstruction = [1700]
UndevelopableProtected = [8888]
Unknown = [9999]



## Create dictionary of all hazard and land use combos ##
hazByLuDict = {}
with arcpy.da.SearchCursor(FC,['OBJECTID','LU16_JOIN',
                               'FLOOD_100_YR','FLOOD_100_YR_PLUS',
                               'FLOOD_500_YR','LANDSLIDE','FIRE_HAZARD',
                               'EARTHQUAKE_HAZARD','TOT_POP_BY_BLOCK',
                               'GEOID','DAM_INUNDATION','MHHW_2100',
                               'COAST_YR_2100_FLOOD'],whereclause) as cursor:
    for row in cursor:
        items = [row[1],row[2],row[3],row[4],row[5],row[6],row[7],row[8],row[9],row[10],row[11],row[12]]
        hazByLuDict.update({row[0]:items})

dict_pairs = hazByLuDict.items()
pairs_iterator = iter(dict_pairs)
first_pair = next(pairs_iterator)



## Define hazard by land use variables ##
TotParcel100 = TotParcel100p = TotParcel500 = TotParcelLandSlide = 0
TotParcelFire = TotParcelEQ = TotParcelPrado = TotParcelmhhw = TotParcelCoastFlood = 0



## Proceed through variables and count occurrence for each hazard type ##
for key,value in hazByLuDict.items():
    if value[1] == '100':
        TotParcel100 += 1
    if value[2] == '100':
        TotParcel100p += 1
    if value[3] == '500':
        TotParcel500 += 1
    if value[4] != '0':
        TotParcelLandSlide += 1
    if value[5] == 'Very High':
        TotParcelFire += 1
    if value[6] == 'MMI of 7 or Higher':
        TotParcelEQ += 1
    if value[9] == 'Prado':
        TotParcelPrado += 1
    if value[10] == 'YES':
        TotParcelmhhw += 1
    if value[11] == 'YES':
        TotParcelCoastFlood += 1

## Sum of population by block group ##
TotPop100 = TotPop100p = TotPop500 = TotPopLandSlide = 0
TotPopFire = TotPopEQ = TotPopPrado = TotPopmhhw = TotPopCoastFlood = 0



## Proceed through variables and sum pop once for each geoid value on parecls that intersect hazards ##
alreadyAdded100yr = alreadyAddedtsunami = alreadyAdded500yr = alreadyAddedlandslide = []
alreadyAddedfire = alreadyAddedeq = alreadyAddedPrado = alreadyAddedmhhw = alreadyAddedCoastFlood = []

for key,value in hazByLuDict.items():
    if value[7] is not None:
        if value[1] == '100' and value[8] not in alreadyAdded100yr:
            TotPop100 += value[7]
            alreadyAdded100yr.append(value[8])

        if value[2] == '100' and value[8] not in alreadyAddedtsunami:
            TotPop100p += value[7]
            alreadyAddedtsunami.append(value[8])

        if value[3] == '500' and value[8] not in alreadyAdded500yr:
            TotPop500 += value[7]
            alreadyAdded500yr.append(value[8])

        if value[4] != '0' and value[8] not in alreadyAddedlandslide:
            TotPopLandSlide += value[7]
            alreadyAddedlandslide.append(value[8])

        if value[5] == 'Very High' and value[8] not in alreadyAddedfire:
            TotPopFire += value[7]
            alreadyAddedfire.append(value[8])

        if value[6] == 'MMI of 7 or Higher' and value[8] not in alreadyAddedeq:
            TotPopEQ += value[7]
            alreadyAddedeq.append(value[8])
            
        if value[9] == 'Prado' and value[8] not in alreadyAddedPrado:
            TotPopPrado += value[7]
            alreadyAddedPrado.append(value[8])
            
        if value[10] == 'YES' and value[8] not in alreadyAddedmhhw:
            TotPopmhhw += value[7]
            alreadyAddedmhhw.append(value[8])
            
        if value[11] == 'YES' and value[8] not in alreadyAddedCoastFlood:
            TotPopCoastFlood += value[7]
            alreadyAddedCoastFlood.append(value[8])


## luDic contains the tags and list of variable values of each land use type that will be addressed in the output report ##

luDic = {'General Office':GeneralOffice,
         'Commercial Services':CommercialServices,
         'Facilities':Facilities,
         'Education':Education,
         'Military Installations':MilitaryInstallations,
         'Industrial':Industrial,
         'Transportation Communications Utilities':TransportationCommunicationsUtilities,
         'Mixed Commercial Industrial':MixedCommercialIndustrial,
         'Open Space Recreation':OpenSpaceRecreation,
         'Agriculture':Agriculture,
         'Vacant':Vacant,
         'Water':Water,
         'Specific Plan':SpecificPlan,
         'Under Construction':UnderConstruction,
         'Undevelopable Protected':UndevelopableProtected,
         'Unknown':Unknown}


### Save export to formatted xlsx spreadsheet and header ###
worksheet = workbook.add_worksheet()
hazardMatrix = [['Landuse','100 yr Flood','Tsunami Innundation',
     '500 yr flood','Landslide','Fire','Earthquake',
     'Prado Inundation','MHHW','Coast Flood']]
    

# Write column headers to top row #
row = 1
for i in hazardMatrix:
    worksheet.write_row('A' + str(row), i)

# write values to table by iterating through items in luDic to get every combo of land use with the associated hazards #
row = 2
for key,i in luDic.items():
    
    hundoJ=hundopJ=fivehundoJ=landslideJ=fireJ=eqJ=pradoJ=mhhwJ=coastfloodJ=0
    
    hundo,hundop,fivehundo,landslide,fire,eq,prado,mhhw,coastflood = calcCountHazard(hazByLuDict,i,
                                                hundoJ,hundopJ,fivehundoJ,landslideJ,fireJ,eqJ,pradoJ,mhhwJ,coastfloodJ)
    hazardMatrix = [[str(key),hundo,hundop,fivehundo,landslide,fire,eq,prado,mhhw,coastflood]]
    print(hazardMatrix)
    for j in hazardMatrix:
        worksheet.write_row('A' + str(row), j)
    row+=1
workbook.close()