ggplot(blah3, aes(x=Month, y=Principal, group=group, col=group, fill=group)) +
  +     geom_point() +
  +     geom_smooth(size=1)

blah$group <- "15 year"
blah2$group <- "30 year"
blah3 <- rbind(blah,blah2)
