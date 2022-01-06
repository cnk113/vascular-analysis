def build(filename, pca = False, umap = False, harmony = True):
    import anndata
    import pandas as pd
    from itertools import chain
    #import scvelo as scv
    ad = anndata.read_mtx('spliced.mtx')
    ad.layers['spliced'] = anndata.read_mtx('spliced.mtx').X
    ad.layers['unspliced'] = anndata.read_mtx('unspliced.mtx').X
    ad.obs = pd.read_csv('meta.csv',header=0)
    if umap:
        ad.obsm['X_umap'] = pd.read_csv('umap.csv',header=0).values
    if pca:
        ad.obsm['X_pca'] = pd.read_csv('pca.csv',header=0).values
    if harmony:
        ad.obsm['X_pca'] = pd.read_csv('harmony.csv', header=0).values
    ad.var_names = list(chain.from_iterable(pd.read_csv('genes.csv', header=0).values.tolist()))
    ad.obs_names = list(chain.from_iterable(pd.read_csv('cells.csv', header=0).values.tolist()))
    ad.write(filename)
