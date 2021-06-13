# posted ----
# blank page https://github.com/RAAmodeo/r_examples/raw/master/pdfs/BLANK_page_for_pdf.pdf
# https://stackoverflow.com/questions/62199136/merge-pdf-files-with-extra-blank-page-at-the-end-of-odd-paged-documents-qpdf

pacman::p_load(tidyverse, pdftools, qpdf, ggplot2)

# some prep
# directory <- "Some/FileFolder/Path"
placeholder <- as.character("https://github.com/RAAmodeo/r_examples/raw/master/pdfs/BLANK_page_for_pdf.pdf")

directory <- "C:/My_R/R/my_learning/r_examples/pdfs"
filelist <- as.data.frame(paste0(directory,
                                "/",
                                list.files(directory,
                                           pattern = "*pdf"))) %>%
  rename(filename = 1)

page_summ <- cbind.data.frame(filelist,
                              page_count = as.numeric(
                                lapply(filelist$filename,
                                       pdf_length))) %>%
  mutate(is_odd = page_count %%2==1)


# Make buffer page using any plot or graphic you wish
plot(-1:1, -1:1, type = "n", xlab = "Re", ylab = "Im")

ggsave(filename = "buffer.pdf",
    plot = last_plot(),
    device = NULL,
    path = directory,
    scale = 1,
    width = NA,
    height = NA,
    units = c("in", "cm", "mm"),
    dpi = 300,
    limitsize = TRUE)

my_buffer <- paste0(directory, "/buffer.pdf")

# Pull out the odd-paged pdfs
my_odds <- page_summ %>%
  filter(is_odd == TRUE) %>%
  select(filename)

my_input <- rbind(new_names, placeholder)
pdf_combine(my_input)


# Add the buffer to each odd-page
lapply(my_input, pdf_combine)

  ggsave(
    filename,
    plot = last_plot(),
    device = pdf,
    path = NULL,
    scale = 1,
    width = NA,
    height = NA,
    units = c("in", "cm", "mm"),
    dpi = 300,
    limitsize = TRUE,
    ...
  )

# add buffer page to each odd paged original doc
buffers <- as.data.frame("Page Intentionally Left Blank")
buffers <- cbind.data.frame(buffers, "X", "Y")

plot.default(buffers)

pdf_render_page(
  new_names$filename,
  page = 1)


# I could not find an R process for adding a page to PDFs.
# For now, I will add a buffer page to docs via a PDF program.
# Once you are satisfied with your even_docs subset, pdf_combine
tocombine <- as.data.frame(even_docs$filename)
lapply(tocombine, pdf_combine)
# This auto-generates the combo file into the previously defined directory.
# The new file name is not able to be set using lapply()
# new file name = "firstnameintocombine_combined.pdf"


# posted 8/28/2020 ----
# This will generate the file in your working directory.
# To save the [png] to a specific folder, enter the full filepath or use 'here::here()'

pdf_convert("Some/file/path/filename.pdf",
            format = "png",
            pages = 1, # use page number
            filenames = "filename" # Set output file name
            )

# posted 8/28/2020 ----
# https://stackoverflow.com/questions/62199136/merge-pdf-files-with-extra-blank-page-at-the-end-of-odd-paged-documents-qpdf

pacman::p_load(tidyverse, pdftools, qpdf)

# some prep
# directory <- "Some/FileFolder/Path"
directory <- "C:/My_R/R/my_learning/r_examples/pdfs"
filelist <- (paste(directory, "/",
                   list.files(directory,
                              pattern = "*20181109.pdf"), sep = ""))
# bust apart all pdf to inspect
my_pages <- as.list(lapply(filelist, pdf_split))
page_summ <- cbind.data.frame(filelist,
                              lengths(my_pages)) %>%
  rename(filename = 1,
         pages = 2) %>%
  mutate(is_odd = pages %%2==1)

# separate into odd and even sets
odd_docs <- page_summ %>%
  filter(is_odd == TRUE)

even_docs <- page_summ %>%
  filter(is_odd == FALSE)

# I could not find an R process for adding a page to PDFs.
# For now, I will add a buffer page to docs via a PDF program.
# Once you are satisfied with your even_docs subset, pdf_combine
tocombine <- as.data.frame(even_docs$filename)
lapply(tocombine, pdf_combine)
# This auto-generates the combo file into the previously defined directory.
# The new file name is not able to be set using lapply()
# new file name = "firstnameintocombine_combined.pdf"

# posted 8/28/2020 ----
# https://stackoverflow.com/questions/62486231/split-a-pdf-file-into-another-2-pdf-file-using-qpdf
# Is it possible to split a PDF file into two parts or n parts using QPDF

pacman::p_load(pdftools, qpdf)
#some prep
bigfile <- "Some/File/Path.pdf"
biginfo <- pdf_length(bigfile)

# now we subset x2 being sure to define unique names for output
# otherwise the second file will overwrite the first one we create here.
# for part 1
pdf_subset(bigfile,
           pages = 1:(biginfo/2),
           output = "Some/File/Path_part_1.pdf")
# for part 2
pdf_subset(bigfile,
           pages = ((biginfo+1)/2):biginfo,
           output = "Some/File/Path_part_2.pdf")

# My first (and deleted) SO Answer ----
set.seed(123)
data <- rexp(1000, 1/3)
X <- matrix(data, 100, 25)
library(tidyverse)
my_count <- as.tibble(X) %>% filter(V10 >=4) %>% nrow()

