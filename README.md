# Determinants of Corporate Bond Credit Spreads (Stata)

Regression analysis of what explains differences in corporate bond credit spreads, using financial, bond-specific and institutional variables, with diagnostics and robustness checks.

**Course:** Advanced Econometrics (Prof. Anis Samet), South Mediterranean University
**Team:** Wiem Habbassi, Manar Ben Salem, Ghofran Ayari, Mariem Limam

## Research question
What factors explain differences in firms' borrowing costs? The credit spread is used as the measure of the cost of debt.

## Hypotheses

| | Hypothesis | Expected sign |
|---|---|---|
| H1 | Higher leverage leads to higher spreads | + |
| H2 | Higher profitability leads to lower spreads | − |
| H3 | Better credit rating leads to lower spreads | − |
| H4 | Stronger debt enforcement leads to lower spreads | − |
| H5 | Longer maturity leads to higher spreads | + |

## Data
- `1-CS-data-CSV.csv` (semicolon-delimited), bond-level data covering firms in 34 countries. The dataset is not included in this repository.
- 3,496 bonds with a spread; 3,408 used in the regressions.
- The spread is strongly right-skewed (mean 131.7, median 79.2, skewness 3.98, kurtosis 32.2).

| Variable | Meaning |
|---|---|
| `sprben_matlab` | Credit spread (dependent variable) |
| `levrage1`, `levrage2` | Leverage (main and alternative measure) |
| `profitability` | Firm profitability |
| `sprat_numeric` | Credit rating on a numeric scale (higher = better rating) |
| `effsale` | Debt enforcement efficiency index |
| `maturity_years` | Bond maturity in years |
| `ln_ta_usd` | Firm size (log of total assets, USD) |
| `civil` | Civil-law legal origin |
| `callable` | Callable bond indicator |
| `ultprnat` | Country of the ultimate parent (encoded as `country_id`) |

## Method (see `Proj.do`)
1. Descriptive statistics, histogram of the spread, scatter plots with fitted lines, pairwise correlations.
2. Baseline OLS of the spread on leverage, profitability, rating, enforcement and maturity.
3. Diagnostics: VIF (mean 1.06, so no multicollinearity concern) and Breusch-Pagan test (chi2 = 1831.6, p < 0.001, so heteroskedasticity is present).
4. Robust standard errors, then robustness checks: alternative leverage measure, firm size, civil law, callable bonds, country-clustered standard errors and country fixed effects.

## Results
Baseline OLS (n = 3,408, adjusted R² = 0.463):

| Variable | Coefficient | p-value | Hypothesis |
|---|---|---|---|
| Leverage (`levrage1`) | 4.87 | 0.663 | H1 not supported |
| Profitability | −144.93 | < 0.001 | H2 supported |
| Credit rating | −33.40 per notch | < 0.001 | H3 supported (strongest driver) |
| Debt enforcement (`effsale`) | −0.343 | 0.002 | H4 supported |
| Maturity | +1.14 per year | 0.001 | H5 supported |

Robustness:
- **Heteroskedasticity-robust SE:** profitability, rating, enforcement and maturity stay significant; leverage stays insignificant.
- **Alternative leverage measure (`levrage2`):** significant and positive (46.0, p = 0.001).
- **Firm size:** larger firms pay lower spreads (−10.46, p < 0.001); adjusted R² rises to 0.469.
- **Civil law:** no independent effect (p = 0.172).
- **Country-clustered SE (34 clusters):** only **credit rating** stays significant. Profitability (p = 0.273), enforcement (p = 0.387) and maturity (p = 0.211) lose significance.
- Callable bonds and country fixed effects were also estimated; see `Proj.do`.

Presentation (including graphs and results) [Project (1).pdf](https://github.com/user-attachments/files/33936307/Project.1.pdf)


## Conclusion
Credit rating is the strongest and most robust determinant of credit spreads. Profitability, debt enforcement and maturity matter in the baseline and with robust standard errors, but not once errors are clustered by country, which suggests country-level factors drive much of the variation in borrowing costs. Leverage has no significant effect in the baseline.

## Limitations
- The spread is highly skewed, so a log transformation could be tested.
- With 34 country clusters, clustered standard errors are conservative.
- OLS shows association, not causation.

## How to run
1. Put `1-CS-data-CSV.csv` in the same folder as `Proj.do`.
2. In Stata, set that folder as the working directory and run `do Proj.do`.

## Files
- `Proj.do`: full analysis code
- `Project (1).pdf/`: Project slides
