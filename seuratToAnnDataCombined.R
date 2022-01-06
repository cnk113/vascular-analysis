seuratToH5AD <- function(seuratObj, h5ad_output, pca=FALSE, umap=FALSE){
  #Sys.setenv(RETICULATE_PYTHON = "/home/chang/miniconda3/envs/venv/bin/python")
  library(reticulate)
  #use_condaenv('venv')
  library(Matrix)
  writeMM(t(seuratObj@assays$RNA@counts), file='combined.mtx')
  writeMM(t(seuratObj@assays$spliced@counts), file='spliced.mtx')
  writeMM(t(seuratObj@assays$unspliced@counts), file='unspliced.mtx')
  write.csv(rownames(seuratObj@assays$spliced@counts), file = "genes.csv", row.names = FALSE)
  if(umap == TRUE){
  	write.csv(seuratObj@reductions$umap@cell.embeddings, file = "umap.csv", row.names = FALSE)
  }
  if(pca == TRUE){
	write.csv(seuratObj@reductions$pca@cell.embeddings, file = "pca.csv", row.names = FALSE)
  }
  write.csv(colnames(seuratObj@assays$spliced@counts), file = "cells.csv", row.names = FALSE)
  write.csv(seuratObj@meta.data, file = "meta.csv", row.names = FALSE)
  source_python('~/build_combined.py')
  build(h5ad_output, pca = pca, umap = umap)
  file.remove('combined.mtx')
  file.remove('spliced.mtx')
  file.remove('unspliced.mtx')
  file.remove('genes.csv')
  file.remove('cells.csv')
  if(umap == TRUE){
  	file.remove('umap.csv')
  }
  if(pca == TRUE){
	file.remove('pca.csv')
  }
  file.remove('meta.csv')
}
