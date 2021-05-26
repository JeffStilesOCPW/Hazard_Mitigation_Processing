# Hazard_Mitigation_Processing
Parcel based hazard analysis Orange County Ca.



Provided in this document are all data sources used for the 2020 hazard mitigation analysis completed by the County of Orange in addition to a brief summary of the analysis completed. This is meant to assist anyone in replicating this process as well as to serve as a guide to replicate analysis in the future. For more detailed instructions on the exact processes used, both the SQL queries and Python scrip are commented with the hope to be easily picked up and re-run or adapted to different jurisdictions’ application as needed.
Sources
Administrative / Boundary Data
County Landbase
https://data-ocpw.opendata.arcgis.com/datasets/parcel-polygons
	SCAG Landuse
		https://gisdata-scag.opendata.arcgis.com/datasets/landuse-combined-orange
	Census Data
		-Formerly American Fact Finder
		-Population by home ownership/renting by block
https://data.census.gov/cedsci/table?q=Homeownership%20Rate&tid=DECENNIALDPCD1132010.113DP1&hidePreview=false
Hazard Data
	Fire Hazard
https://gis.data.ca.gov/datasets/CALFIRE-Forestry::fhsz-in-lra
Landslide
https://services.gis.ca.gov/arcgis/rest/services/GeoscientificInformation/Potential_Landslides/MapServer
Earthquake
M 7.8 Scenario Earthquake - Shakeout2 Full Scenario (usgs.gov)
100 Year Flood
https://services.gis.ca.gov/arcgis/rest/services/InlandWaters/Flood_Risk_FEMA/MapServer/0
 
500 Year Flood
https://services.gis.ca.gov/arcgis/rest/services/InlandWaters/Flood_Risk_FEMA/MapServer/2
Tsunami Inundation
https://www.conservation.ca.gov/cgs/tsunami/maps/orange

Database Requirements and Technical Notes
	For the purposes of this analysis the data was loaded into a Microsoft SQL enterprise geodatabase environment. In order to replicate the analysis this is recommended; however other SQL DBMS could be used. SQL Spatial functions were preferred over native ESRI tools due to speed of processing considering the size of the datasets. This allowed tools to be run and re-run quickly while testing and processing different hazard scenarios. The parameters and thresholds used in the county’s analysis could be changed or adjusted for other jurisdictions as those running the analysis see fit.

Processes and Key Points
- 	SQL intersections for data analysis
	- Use spatial index of table while processing intersect in SQL
	- intersect and aggregate hazard data by county parcel
- Intersects performed were done by applying the values of the hazard to any parcel that touched any part of the hazard area. 
-In the case of multiple hazard values the one with the larger area intersecting the parcel was the value assigned to the given parcel.

-	Python Automation for report creation / data export
- summarize data by land use and count number of parcels within affected hazard areas, summarize census data by count of people within hazard zones
	- Reference to feature class / geodatabase with .sde connection file
		-set path to .sde file as variable, reference going forward
	- Save value counts and write to lists/dictionaries within script to organize for the final output to excel table  
	- Where clause defined at beginning to limit output by certain attributes in aggregating dataset
- The County used two categories defined in the data to break out export data further, within or outside of county jurisdictional area.
