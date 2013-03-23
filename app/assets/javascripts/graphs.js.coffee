$ ->
  if gon?
    console.log gon.data
    chart = new Highcharts.Chart
      chart:
        renderTo: "highchart-container"
        type: "spline"
        zoomType: "x"

      xAxis:
        type: "datetime"

      series:
        [
          name: "Cumulative graph",
          data: gon.data
        ]