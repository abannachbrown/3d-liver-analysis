table(reconciled$`4.1 What kind of printing method is used?_ae684e28-4f90-44ad-9de2-731d076de0b0_Answer`)




# type --> 
bioink <- reconciled %>%select(
  study_ID, 
  `4.1.3 What type of bioink was used?_92421414-c597-4e9c-b720-9bb4318b5483_Answer`, 
  `4.1.3.1.1 If natural bioink, please choose the type._66b761ad-6630-4323-b423-c848a717aae4_Answer`, 
  `4.1.3.1.4Â If Synthetic bioink: choose the type _e74ea0e0-a654-4ae2-b59e-2e0b14a4651a_Answer`, `4.1.3.1.2Â If Protein based: choose the type._621671b3-9f7e-4a22-80ac-14b02fdd0683_Answer`, 
  `4.1.3.1.3 If Polysaccharides Based: choose the type. _fcea8bcb-da6c-4154-aa44-8ff4734fa4fe_Answer`
)  


bioink <- bioink  %>% rename(typeGeneral_level1 = `4.1.3 What type of bioink was used?_92421414-c597-4e9c-b720-9bb4318b5483_Answer`, 
                             typeNatural_level2 = `4.1.3.1.1 If natural bioink, please choose the type._66b761ad-6630-4323-b423-c848a717aae4_Answer`, 
                             typeSynthetic_level2 = `4.1.3.1.4Â If Synthetic bioink: choose the type _e74ea0e0-a654-4ae2-b59e-2e0b14a4651a_Answer`, 
                             typeProtein_level3 = `4.1.3.1.2Â If Protein based: choose the type._621671b3-9f7e-4a22-80ac-14b02fdd0683_Answer`, 
                             typePoly_level3 = `4.1.3.1.3 If Polysaccharides Based: choose the type. _fcea8bcb-da6c-4154-aa44-8ff4734fa4fe_Answer`
)

bioink_split1 <- separate_rows(bioink, typeGeneral_level1 , sep="\\|")
bioink_split1_1 <- separate_rows(bioink_split1, typeNatural_level2 , sep="\\|")

bioink_split1_2 <- separate_rows(bioink_split1_1, typeProtein_level3 , sep="\\|")

bioink_split1_3 <- separate_rows(bioink_split1_2, typePoly_level3 , sep="\\|")

bioink_split2 <- separate_rows(bioink_split1_3, typeNatural_level2 , sep=";")
bioink_split3 <- separate_rows(bioink_split2, typeProtein_level3 , sep=";")
bioink_split3 <- separate_rows(bioink_split3, typePoly_level3 , sep=";")
# 148 rows
# 164 rows

test_bio <- bioink_split3 %>%
  mutate(typeNatural_level2 = replace(typeNatural_level2, typeGeneral_level1!="Natural", NA), 
         typeSynthetic_level2 = replace(typeSynthetic_level2, typeGeneral_level1!="Synthetic", NA), 
         typeProtein_level3 = replace(typeProtein_level3, typeNatural_level2!="Protein based", NA), 
         typePoly_level3 =  replace(typePoly_level3, typeNatural_level2!="Polysaccharide based", NA)
  )

test_bio$typeSynthetic_level2 <- as.character(test_bio$typeSynthetic_level2)


### merge level 2 & merge level 3 
test_bio$level3 <- ifelse(!is.na(test_bio$typeProtein_level3), test_bio$typeProtein_level3, test_bio$typePoly_level3)

test_bio$level2 <- ifelse(!is.na(test_bio$typeNatural_level2), test_bio$typeNatural_level2, test_bio$typeSynthetic_level2)



#### START PLOTTING

library(dplyr)
library(plotme)


bioInk_count <-  count(test_bio, 
                       typeGeneral_level1, 
                       level2,
                       level3
                       #,study_ID
)


# sunburst plot
count_to_sunburst(bioInk_count)