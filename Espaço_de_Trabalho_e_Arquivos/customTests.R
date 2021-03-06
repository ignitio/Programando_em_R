notify <- function() {
  e <- get("e", parent.frame())
  if(e$val == "No") return(TRUE)
  
  good <- FALSE
  while(!good) {
    # Get info
    name <- readline_clean("Qual � o seu nome completo? ")
    address <- readline_clean("Qual � o endere�o de email da pessoa que voc� gostaria de notificar? ")
    
    # Repeat back to them
    message("\nT� tudo direitinho?\n")
    message("Seu nome: ", name, "\n", "Enviar para: ", address)
    
    yn <- select.list(c("Sim", "N�o"), graphics = FALSE)
    if(yn == "Sim") good <- TRUE
  }
  
  # Get course and lesson names
  course_name <- attr(e$les, "course_name")
  lesson_name <- attr(e$les, "lesson_name")
  
  subject <- paste(name, "rec�m completou", course_name, "-", lesson_name)
  body = ""
  
  # Send email
  swirl:::email(address, subject, body)
  
  hrule()
  message("Tentei criar um novo email com as seguintes informa��es:\n")
  message("Para: ", address)
  message("Assunto: ", subject)
  message("Body: <empty>")
  
  message("\nSe n�o funcionou, voc� pode enviar o mesmo email manualmente.")
  hrule()
  
  # Return TRUE to satisfy swirl and return to course menu
  TRUE
}

readline_clean <- function(prompt = "") {
  wrapped <- strwrap(prompt, width = getOption("width") - 2)
  mes <- stringr::str_c("| ", wrapped, collapse = "\n")
  message(mes)
  readline()
}

hrule <- function() {
  message("\n", paste0(rep("#", getOption("width") - 2), collapse = ""), "\n")
}