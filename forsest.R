library(forestploter)
funl <- read.csv("your_filename",header = T,fileEncoding = 'GBK')
funl$' ' <- paste0(rep(" ",20),collapse = " ")
funl$`OR (95% CI)` <- ifelse(is.na(funl$or), "",
                           sprintf("%.2f (%.2f to %.2f)",
                                   funl$or, funl$or_lci95, funl$or_uci95))#sprintF返回字符和可变量组合
funl[is.na(funl)] <- " "
tm <- forest_theme(base_size = 10,
                   ci_pch = 20,
                   ci_col = "#4575b4",
                   ci_lty = 1,
                   ci_lwd = 2.3,
                   ci_Theight = 0.2,
                   refline_lwd = 1.5,
                   refline_lty = "dashed",
                   refline_col = "red",
                   summary_col = "#4575b4",
                   summary_fill = "#4575b4",
                   footnote_cex = 1.1,
                   footnote_fontface = "italic",
                   footnote_col = "blue")

p <- forest(funl[,c(1:4,8:9)],
            est = funl$or,
            lower = funl$or_lci95,
            upper = funl$or_uci95,
            sizes = 0.6,
            ci_column = 5,
            ref_line = 1,
            xlim = c(0,2),
            ticks_at = c(0,1,2),
            arrow_lab = c('Decreased Risk','Increased Risk'),
            footnote = '# Multiplicative Random Effects was used for IVW',
            theme = tm
            )
p

print(p)
