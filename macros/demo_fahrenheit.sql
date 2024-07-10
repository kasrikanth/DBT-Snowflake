{% macro to_celsium(fahrenheit_colums, display_places) %}
 ROUND(({{fahrenheit}}-32)*5/9, {{ decmial_places}})
{% endmacro %}