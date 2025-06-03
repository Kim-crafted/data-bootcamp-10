---
title: "HW DataViz Batch10"
author: "Kim"
date: "2024-10-07"
output:
  html_document: default
  pdf_document: default
---

```{r}
library(tidyverse)
library(ggplot2)
```

## Data Preparation

```{r}
#Row to column & mutate am
mtcars2 <- mtcars%>%
  rownames_to_column(var = "model")%>%
  mutate(am = ifelse( am == 0, "Auto", "Manual"))%>%
  tibble()

#am to factor
mtcars2$am <- factor(mtcars2$am,
                     levels = c("Auto", "Manual"),
                     labels = c("Auto", "Manual"))
```

# Exploring automobiles in 1973-1974

```{r}

ggplot(mtcars2, aes(am, fill = am))+
  geom_bar(show.legend = FALSE)+
  scale_fill_manual(values = c("#3363ff", "#ff3333"))+
  labs(x = "Transmission",
       y = "Models") +
  theme_minimal()+
  theme(axis.title.y = element_text(angle = 0))+
  geom_text(stat = "count", aes(label = after_stat(count)),
            vjust = 2,
            color = "white")
```

Most of available model in the market is automatic transmission.

```{r}
ggplot(mtcars2, aes(am, mpg, fill = am))+
  geom_boxplot(show.legend = FALSE)+
    scale_fill_manual(values = c("#3363ff", "#ff3333"))+
    labs(x = "Transmission",
        y = "Models") +
    theme_minimal()+
    theme(axis.title.y = element_text(angle = 0))
```

Even though, manual transmission have more fuel efficiency (higher mpg), it might be because manufacturer had manufactured based on urban lifestyle which convenience of driving is one of the top priorities.

```{r}
ggplot(subset(mtcars2, hp < 300), aes(hp, mpg, color = am))+
  geom_point()+
  geom_smooth(method = "lm", se = FALSE)+
  scale_color_manual(values = c("#3363ff", "#ff3333"))+
  theme(legend.position = "Right")+
  theme_minimal()+
  theme(axis.title.y = element_text(angle = 0))
```


Cars with higher horsepower(hp) have higher fuel consumption (lower mpg).
In 1974, considering buying a car in terms of city driving and fuel efficiency, automatic transmission car with a horsepower in a range of 70-150 might not be a bad idea.

```{r}
mtcars2_cit <- mtcars2%>%
  filter(between(hp, 70, 150) & am == "Auto")%>%
  select(model, hp, mpg)%>%
  arrange(hp)%>%
  mutate(model = factor(model, levels=model))

ggplot(mtcars2_cit, aes(hp, model, fill = hp))+
  geom_col(show.legend = FALSE)+
  scale_fill_gradient2(mid = "white" ,high = "blue")+
  labs(y = "Model")+
  theme_minimal()+
  theme(axis.title.y = element_text(angle = 0))+
  geom_text(aes(label = hp),
            position = position_stack(vjust = 0.9),
            color = "white")
```

Here's the List of cars with horsepower in a range of 70-150


```{r}
ggplot(mtcars2_cit, aes(hp, mpg, fill = model))+
  geom_text(aes(label = model))+
  theme_minimal()
```


Considering with fuel efficiency would be easier to decide.
