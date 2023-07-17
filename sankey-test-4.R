## snakey


screening_info = ['Records obtained from the Medline database',
                  'Records obtained from previous reviews',
                  """
                    Exclusion critera:<br>
                    - work relying only on MRI;<br>
                    - work relying only on histology or equivalent approach;<br>
                    - work reporting only qualitative comparisons.
                  """,
                  'Records selected for full-text evaluation',
                  """
                    Exclusion criteria:<br>
                    - studies using MRI-based measures in arbitrary units;<br>
                    - studies using measures of variation in myelin content;<br>
                    - studies using arbitrary assessment scales;<br>
                    - studies comparing absolute measures of myelin with relative measures;<br>
                    - studies reporting other quantitative measures than correlation or R^2 values;<br>
                    - studies comparing histology from one dataset and MRI from a different one.
                  """,
                  'Studies selected for literature overview',
                  """
                    Exclusion criteria:<br>
                     - not providing an indication of both number of subjects and number of ROIs.
                  """]

fig1 = go.Figure(data=[go.Sankey(
  arrangement = "freeform",
  node = dict(
    pad = 15,
    thickness = 20,
    line = dict(color = "black", width = 0.5),
    label = ["Main records identified (database searching)",
             "Additional records (reviews)",
             "Records screened",
             "Records excluded",
             "Full-text articles assessed for eligibility",
             "Full-text articles excluded",
             "Studied included in the literature overview",
             "Studies included in the meta-analysis"],
    x = [0, 0, 0.4, 0.6, 0.5, 0.8, 0.7, 1],
    y = [0, 0, 0.5, 0.8, 0.15, 0.05, 0.4, 0.6],
    hovertemplate = "%{label}<extra>%{value}</extra>",
    color = ["darkblue","darkblue","darkblue","darkred","darkgreen","darkred","darkgreen","darkgreen"]
  ),
  link = dict(
    source = [0, 1, 2, 2, 4, 4, 6],
    target = [2, 2, 3, 4, 5, 6, 7],
    value = [688, 1, 597, 92, 34, 58, 43],
    customdata = screening_info,
    hovertemplate = "%{customdata}",
  ))])

fig1.update_layout(images=[dict(
  source="neurolibre.svg",
  xref="paper", yref="paper",
  x=1.02, y=-0.21,
  sizex=0.05, sizey=0.05,
  xanchor="right", yanchor="bottom"
)],
width=950,
height=500,
font_size=12)

fig1.add_annotation(x=1.003, y=-0.205, xref="paper", yref="paper",
                    text="<a href=\"https://neurolibre.com\" target=\"_blank\" " +
                      "style=\"color:gray!important\">NeuroLibre</a>", showarrow=False)

fig1.show()