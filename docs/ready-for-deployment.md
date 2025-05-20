# Ready for Deployment

![](./img/project.png)

As illustrated in the above diagram, this project provides two types of online
resources to support users and developers:

- [MkDocs project website](https://aafulei.github.io/cpp-today/)
- [Doxygen source code documentation](https://aafulei.github.io/cpp-today/doxygen/html/)

MkDocs website hosts user guides and general project documentation, while
Doxygen pages offer detailed source code documentation for reference.

This document outlines the basic steps to deploy these two websites.

## Deploy MkDocs Website

### 1. Set up Environment

Create a Python virtual environment at the root of the project to isolate
dependencies:

```shell
python -m venv venv
```

Activate the virtual environment:

```shell
source venv/bin/activate
```

Install [MkDocs](https://www.mkdocs.org/) and the
[Material](https://squidfunk.github.io/mkdocs-material/) theme:

```shell
pip install mkdocs mkdocs-material
```

### 2. Configure

Modify [`mkdocs.yml`](https://github.com/aafulei/cpp-today/blob/main/mkdocs.yml)
to configure the project website. Most options are well documented at the
MkDocs and Material websites. The additional
[`docs/css/custom-mkdocs.css`](https://github.com/aafulei/cpp-today/blob/main/docs/css/custom-mkdocs.css)
file increases the font size for tables in Markdown files.

### 3. Preview

To preview the MkDocs project website locally, run:

```shell
mkdocs serve
```

MkDocs includes a live preview server accessible at
`http://127.0.0.1:8000` that allows you to preview your
changes as you write documentation. Any changes to the `mkdocs.yml`
configuration file and markdown files inside the
[`docs`](https://github.com/aafulei/cpp-today/blob/main/docs/)
directory will be reflected in real time.

### 4. Deploy

To deploy the MkDocs project website, run:

```shell
mkdocs gh-deploy
```

MkDocs will build the source files in the `docs` directory into a static site
inside the `site` directory (in
[`.gitignore`](https://github.com/aafulei/cpp-today/blob/main/.gitignore)).
It will then deploy this `site` to the
[`gh-pages`](https://github.com/aafulei/cpp-today/tree/gh-pages)
branch of the GitHub repository. GitHub Pages will handle updates and render the
project website.

## Deploy Doxygen Documentation

### 1. Set up Environment

On macOS, install Doxygen by running

```shell
brew install doxygen
```

Generate a template configuration file:

```shell
doxygen -g Doxygen.original
```

Generate a template layout file:

```shell
doxygen -l DoxygenLayout.original.xml
```

Do not edit these original files directly (add them to `.gitignore`). Instead,
make copies for editing, which makes it easier to track changes later:

```shell
cp Doxyfile.original Doxyfile
cp DoxygenLayout.original.xml DoxygenLayout.xml
```

### 2. Configure Docs Generation

Modify the
[`Doxyfile`](https://github.com/aafulei/cpp-today/blob/main/Doxyfile)
to configure documentation generation. To review your changes, run:

```shell
diff Doxyfile.original Doxyfile
```

For this project, the modified settings are:

| Key                     | Value                                                                                                                   |
| ----------------------- | ----------------------------------------------------------------------------------------------------------------------- |
| `PROJECT_NAME`          | "CppToday"                                                                                                              |
| `PROJECT_BRIEF`         | "What day is it today? A minimal C++23 program."                                                                        |
| `PROJECT_LOGO`          | [`docs/img/logo-doxygen.svg`](https://github.com/aafulei/cpp-today/blob/main/docs/img/logo-doxygen.svg)                 |
| `PROJECT_ICON`          | [`docs/img/icon.svg`](https://github.com/aafulei/cpp-today/blob/main/docs/img/icon.svg)                                 |
| `OUTPUT_DIRECTORY`      | `docs/doxygen` (in `.gitignore`)                                                                                        |
| `LAYOUT_FILE`           | [`DoxygenLayout.xml`](https://github.com/aafulei/cpp-today/blob/main/DoxygenLayout.xml) (see below)                     |
| `INPUT`                 | [`src`](https://github.com/aafulei/cpp-today/blob/main/src/)                                                            |
| `RECURSIVE`             | `YES` (will look recusrively into `src`)                                                                                |
| `EXCLUDE`               | [`tests`](https://github.com/aafulei/cpp-today/blob/main/tests/)                                                        |
| `HTML_EXTRA_STYLESHEET` | [`docs/css/custom-doxygen.css`](https://github.com/aafulei/cpp-today/blob/main/docs/css/custom-doxygen.css) (see below) |
| `DISABLE_INDEX`         | `NO` (will show horizontal tabs at top)                                                                                 |
| `HTML_FORMULA_FORMAT`   | `svg` (instead of `png`; requires [Inkscape](https://inkscape.org/))                                                    |
| `GENERATE_LATEX`        | `NO`                                                                                                                    |
| `HAVE_DOT`              | `YES` (requires [Graphviz](https://graphviz.org/download/), for `svg`)                                                  |
| `CALL_GRAPH`            | `YES`                                                                                                                   |
| `CALLER_GRAPH`          | `YES`                                                                                                                   |
| `DOT_IMAGE_FORMAT`      | `svg` (instead of `png`, for nicer look)                                                                                |

The most important setting for Doxygen is `INPUT`, which tells Doxygen to look
into the `src` directory and its subdirectories, parsing code and comments to
generate corresponding documentation.

The extra
[`docs/css/custom-doxygen.css`](https://github.com/aafulei/cpp-today/blob/main/docs/css/custom-doxygen.css)
removes the panel synchronization button from the Doxygen website, which the
author finds distracting.

### 3. Configure Layout

Edit
[`DoxygenLayout.xml`](https://github.com/aafulei/cpp-today/blob/main/DoxygenLayout.xml)
to customize the layout for Doxygen pages. To see your changes, run:

```shell
diff DoxygenLayout.original.xml DoxygenLayout.xml
```

In this project, the following lines were added to the `<navindex>` element to
add two tabs for quick navigation to the GitHub repository and the MkDocs
project website:

```xml
<tab type="user" url="http://github.com/aafulei/cpp-today/" title="GitHub"/>
<tab type="user" url="../../" title="Back to Project Website"/>
```

### 4. Deploy

Because MkDocs manages the entire `docs` directory and Doxygen outputs HTML
files inside `docs/doxygen`, no additional deployment steps are needed. Running:

```shell
mkdocs gh-deploy
```

will deploy both the MkDocs site and the Doxygen-generated pages as part of
the overall project website.

---

*For source code and project files, please see the
[GitHub repository](https://github.com/aafulei/cpp-today).*
