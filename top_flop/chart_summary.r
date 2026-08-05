
manual_chart_ids <-  c(
  # FR
  "b6w1U","yuXg3",
  "N5EPN","Gbd3L",
  "iOHcE","CxB1Z",
  "b51TV","ghurA",
  "bKE7p","bP1w2",
  
  # DE
  "Dx1fO","a7eVM",
  "i1RhM","Bsp3H",
  "VqlJy","cJ9NA",
  "Ir09o","ic1Hw",
  "k5NEY","tFhxa",
  
  # IT
  "UTWq0","2LB0K",
  "Pkwo0","WENIo",
  "ROaJd","80Rpw",
  "Urowj","JMav4",
  "P86Hn","z4Xpy"
)






kantonale_id <- c("jjjYB","6q0ZA","u4Rfa")


manual_chart_summary <- data.frame("",
                                   "",
                                   "",
                                   "",
                                   "",
                                   "",
                                   "",
                                   "")

manual_chart_summary <- data.frame(matrix(ncol = length(manual_chart_summary), nrow = 0))

colnames(manual_chart_summary) <- c("Typ","Vorlage","Titel","Sprache","ID","Link","Iframe","Script")


#retrive_test <- dw_retrieve_chart_metadata("Sw6RJ")

#retrive_test$content$title

for (chart_id in manual_chart_ids) {
  
  # Récupérer les métadonnées du graphique
  metadata_chart <- DatawRappr::dw_retrieve_chart_metadata(chart_id)
  
  # Créer une nouvelle entrée de métadonnées
  new_entry <- data.frame(
    "Typ" = "Top10",
    "Vorlage" = "alle",
    "Titel" = metadata_chart$content$title,
    "Sprache" = metadata_chart$content$language,
    "ID" = metadata_chart$id,
    "Link" = metadata_chart$content$publicUrl,
    "Iframe" = metadata_chart$content$metadata$publish$`embed-codes`$`embed-method-responsive`,
    "Script" = metadata_chart$content$metadata$publish$`embed-codes`$`embed-method-web-component`
  )
  
  # Ajouter la nouvelle entrée au tableau récapitulatif
  manual_chart_summary <- rbind(manual_chart_summary, new_entry)
}

manual_chart_summary <- manual_chart_summary %>%
  dplyr::mutate(date = "2026-03-08",
         Typ = dplyr::case_when(ID %in% kantonale_id ~ "Kantone",
                                TRUE ~ as.character("Top10")))

save_xlsx <- "C:/Users/yove/OneDrive - KEYSTONE-SDA-ATS AG/Dokumente/selfpick/data-raw/resources/vot_fed_03_2026/top_flop_summaries.xlsx"

writexl::write_xlsx(manual_chart_summary, save_xlsx)
