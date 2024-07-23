# gis-584-uas-course

Course website for GIS/MAE 584 Mapping and Analytics Using UAS

## Configuration

Install Quarto following the directions at [https://quarto.org/docs/get-started/](https://quarto.org/docs/get-started/)

## Development

To start the development server, run:

```bash
quarto preview
```

### Optimize Images

Convert images to webp format using the following commands:

```bash
mogrify -format webp -quality 80 *.png
mogrify -format webp -quality 80 *.jpg
```
