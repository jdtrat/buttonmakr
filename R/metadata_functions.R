library(rvest)

#' Scrape Open Graph Metadata from Websites
#'
#' @param url Character string of a website url
#'
#' @return A tidy dataframe with the Open Graph metadata paramaters, such as
#'   title, description, and image.
#'
#' @importFrom rlang .data
#'
#' @export
#'
#' @examples get_metadata("https://www.eurekalert.org/pub_releases/2020-10/wfbm-srr100920.php")
get_metadata <- function(url) {

  nodes <- xml2::read_html(url) %>%
    rvest::html_nodes(xpath = '//meta[@property]')

  content <- nodes %>%
    rvest::html_attr("content")

  title <- nodes %>%
    rvest::html_attr("property") %>%
    stringr::str_extract("(?<=og:).*")

  output <- tibble::tibble(title, content) %>%
    tidyr::drop_na()

  if (!"url" %in% output$title) {
    output %<>%
      dplyr::bind_rows(
        data.frame(title = "url",
                   content = url))
  }

  return(output)

}


#' Create a button link from meta data
#'
#' @param metadata The output of get_metadata
#'
#' @return HTML text defining a button with the title, url, and image from the website's meta data.
#' @export
#'
#' @examples
#' get_metadata("https://www.eurekalert.org/pub_releases/2020-10/wfbm-srr100920.php") %>%
#' create_button_html()
#'
create_button_html <- function(metadata) {

  title <- metadata %>%
    dplyr::filter(.data$title == "title") %>%
    dplyr::pull(.data$content)

  url <- metadata %>%
    dplyr::filter(.data$title == "url") %>%
    dplyr::pull(.data$content)

  image <- metadata %>%
    dplyr::filter(.data$title == "image") %>%
    dplyr::pull(.data$content)

  glue::glue("
           <button class=\"button\" onclick = \"window.open('{url}')\" style = \"background-image: url('{image}');\">
  <span class = \"text-background\">
  <span class = \"title-text\">
  {title}
</span>
  <span class = url-text>
{url}
</span>
  </span>
  </button>
           ")

}
