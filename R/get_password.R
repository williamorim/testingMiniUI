get_password <- function() {
  ui <- miniUI::miniPage(
    miniUI::gadgetTitleBar("Please enter your password"),
    miniUI::miniContentPanel(
      shiny::passwordInput("password", "")
    ),
    shiny::br(),
    shiny::actionButton("abrir", "Abrir outro gadget")
  )

  server <- function(input, output) {
    shiny::observeEvent(input$done, {
      shiny::stopApp(input$password)
    })
    shiny::observeEvent(input$cancel, {
      shiny::stopApp(stop("No password.", call. = FALSE))
    })
    shiny::observeEvent(input$abrir, {
      rstudioapi::jobRunScript(
        path = system.file("get_password2.R", package = "testingMiniUI")
      )
    })
  }

  shiny::runGadget(ui, server, viewer = shiny::dialogViewer("Password", height = 200))
}
