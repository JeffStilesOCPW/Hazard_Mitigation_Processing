---- Clear All Data When Running New Calcs ----
-- Set all values back to 0 or negative to start with blank slate of data --


---- Reset Parcel Hazards ----
-- Update Earthquake Hazard zone --
UPDATE [OCSurvey].[dbo].[HM_2020_LEGAL_LOTS_ALL_DATA]
SET [EARTHQUAKE_HAZARD] = ('Not MMI of 7 or Higher'),--(b.GRID_CODE)
    [FIRE_HAZARD] = ('No Fire Zone'),
    [FLOOD_100_YR_PLUS] = (0),
    [FLOOD_100_YR] = (0),
    [FLOOD_500_YR] = (0),
    [MHHW_2100] = ('NO'),
    [COAST_YR_2100_FLOOD] = ('NO'),
    [DAM_INUNDATION] = ('Not Prado'),
    [BLOCK_NAME] = (0),
    [GEOID] = (0),
    [LANDSLIDE] = (0)


---- Reset Facility Hazards ----
-- Update Earthquake Hazard zone --
UPDATE [OCSurvey].[dbo].[HM_2020_COUNTY_PROPERTIES]
SET [EARTHQUAKE_HAZARD] = ('Not MMI of 7 or Higher'),
[FIRE_HAZARD] = ('No Fire Zone'),
[FLOOD_100_YR_PLUS] = (0),
[FLOOD_100_YR] = (0),
[FLOOD_500_YR] = (0),
[MHHW_2100] = ('NO'),
[COAST_YR_2100_FLOOD] = ('NO'),
[DAM_INUNDATION] = ('Not Prado'),
[LANDSLIDE] = (0)
