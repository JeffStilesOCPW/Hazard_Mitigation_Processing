---- Clear All Data When Running New Calcs ----
-- Set all values back to 0 or negative to start with blank slate of data --


---- Reset Parcel Hazards ----
-- Update Earthquake Hazard zone --
UPDATE [OCSurvey].[dbo].[HM_2020_LEGAL_LOTS_ALL_DATA]
SET [EARTHQUAKE_HAZARD] = 'Not MMI of 7 or Higher'--(b.GRID_CODE)

-- Update Fire Hazard zone LRA --
UPDATE [OCSurvey].[dbo].[HM_2020_LEGAL_LOTS_ALL_DATA]
SET [FIRE_HAZARD] = ('No Fire Zone')

-- Update Fire Hazard zone SRA --
UPDATE [OCSurvey].[dbo].[HM_2020_LEGAL_LOTS_ALL_DATA]
SET [FIRE_HAZARD] = ('No Fire Zone')

-- Update 100 yr Plus (Tsunami Innundation) flood field --
UPDATE [OCSurvey].[dbo].[HM_2020_LEGAL_LOTS_ALL_DATA]
SET [FLOOD_100_YR_PLUS] = (0)

-- Update 100 yr flood field --
UPDATE [OCSurvey].[dbo].[HM_2020_LEGAL_LOTS_ALL_DATA]
SET [FLOOD_100_YR] = (0)

-- Update 500 yr flood field --
UPDATE [OCSurvey].[dbo].[HM_2020_LEGAL_LOTS_ALL_DATA]
SET [FLOOD_500_YR] = (0)

-- Update mhhw  --
UPDATE [OCSurvey].[dbo].[HM_2020_LEGAL_LOTS_ALL_DATA]
SET [MHHW_2100] = ('NO')

-- Update CoastFlood --
UPDATE [OCSurvey].[dbo].[HM_2020_LEGAL_LOTS_ALL_DATA]
SET [COAST_YR_2100_FLOOD] = ('NO')

-- Update Prado Dam Innundation Zone --
UPDATE [OCSurvey].[dbo].[HM_2020_LEGAL_LOTS_ALL_DATA]
SET [DAM_INUNDATION] = ('Not Prado')

-- Update Census Block Name field --
UPDATE [OCSurvey].[dbo].[HM_2020_LEGAL_LOTS_ALL_DATA]
SET [BLOCK_NAME] = (0)

-- Update Census GEOID field --
UPDATE [OCSurvey].[dbo].[HM_2020_LEGAL_LOTS_ALL_DATA]
SET [GEOID] = (0)

-- Update USGS Landslide Hazard Confidence Field --
UPDATE [OCSurvey].[dbo].[HM_2020_LEGAL_LOTS_ALL_DATA]
SET [LANDSLIDE] = (0)





---- Reset Facility Hazards ----
-- Update Earthquake Hazard zone --
UPDATE [OCSurvey].[dbo].[HM_2020_COUNTY_PROPERTIES]
SET [EARTHQUAKE_HAZARD] = 'Not MMI of 7 or Higher'

-- Update Fire Hazard zone LRA --
UPDATE [OCSurvey].[dbo].[HM_2020_COUNTY_PROPERTIES]
SET [FIRE_HAZARD] = ('No Fire Zone')

-- Update Fire Hazard zone SRA --
UPDATE [OCSurvey].[dbo].[HM_2020_COUNTY_PROPERTIES]
SET [FIRE_HAZARD] = ('No Fire Zone')

-- Update 100 yr Plus (Tsunami Innundation) flood field --
UPDATE [OCSurvey].[dbo].[HM_2020_COUNTY_PROPERTIES]
SET [FLOOD_100_YR_PLUS] = (0)

-- Update 100 yr flood field --
UPDATE [OCSurvey].[dbo].[HM_2020_COUNTY_PROPERTIES]
SET [FLOOD_100_YR] = (0)

-- Update 500 yr flood field --
UPDATE [OCSurvey].[dbo].[HM_2020_COUNTY_PROPERTIES]
SET [FLOOD_500_YR] = (0)

-- Update mhhw  --
UPDATE [OCSurvey].[dbo].[HM_2020_COUNTY_PROPERTIES]
SET [MHHW_2100] = ('NO')

-- Update CoastFlood --
UPDATE [OCSurvey].[dbo].[HM_2020_COUNTY_PROPERTIES]
SET [COAST_YR_2100_FLOOD] = ('NO')

-- Update Prado Dam Innundation Zone --
UPDATE [OCSurvey].[dbo].[HM_2020_COUNTY_PROPERTIES]
SET [DAM_INUNDATION] = ('Not Prado')

-- Update USGS Landslide Hazard Confidence Field --
UPDATE [OCSurvey].[dbo].[HM_2020_COUNTY_PROPERTIES]
SET [LANDSLIDE] = (0)
