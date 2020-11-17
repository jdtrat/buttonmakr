# buttonmakr

This is a learning project to create buttons similar to those on seen with iMessage, Facebook, or Twitter, that preview the metadata for different links. It is still a work in progress, but the package can be installed as follows:

```r

devtools::install_github("jdtrat/buttonmakr")
library(buttonmakr)

```

Its main functions are `get_metadata()`, which takes in a url and returns a tibble containing [og metadata properties](https://ogp.me), and `create_button_html()`, which takes in the metadata tibble and generates the HTML code for a button displaying the associated image and title. The button generated will open the url when clicked.

I've created a demo Shiny app for this [here](https://jdtrat-apps.shinyapps.io/button_maker/). The Shiny app code is [here](https://github.com/jdtrat/buttonmakr/tree/master/button_maker).
