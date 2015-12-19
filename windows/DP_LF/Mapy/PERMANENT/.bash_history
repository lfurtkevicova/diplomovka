v.in.ogr -o --overwrite input=C:\DP_LF\data layer=zu output=area min_area=0.0001 snap=-1 geometry=None
v.in.ogr -o --overwrite input=C:\DP_LF\data layer=geology output=geology min_area=0.0001 snap=-1 geometry=None
v.in.ogr -o --overwrite input=C:\DP_LF\data layer=polohopis output=polohopis min_area=0.0001 snap=-1 geometry=None
v.in.ogr -o --overwrite input=C:\DP_LF\data layer=vyskopis output=vyskopis min_area=0.0001 snap=-1 geometry=None
v.in.ogr -o --overwrite input=C:\DP_LF\data layer=zosuvy output=zosuvy min_area=0.0001 snap=-1 geometry=None
g.region --overwrite vector=area res=10
v.to.rast --overwrite input=area layer=1 type=point,line,area output=zu use=attr attribute_column=Id value=1 memory=300
v.to.rast --overwrite input=geology layer=1 type=point,line,area output=geology use=attr attribute_column=kat value=1 memory=300
v.to.rast --overwrite input=polohopis layer=1 type=point,line,area output=landuse use=attr attribute_column=Id value=1 memory=300
v.to.rast --overwrite input=zosuvy layer=1 type=point,line,area output=zosuvy0 use=attr attribute_column=Id value=1 memory=300
r.mapcalc --overwrite expression=zosuvy = if( zosuvy0 == 0, null(), 1)
r.mask --overwrite raster=zu maskcats=* layer=1
v.surf.rst --overwrite input=vyskopis layer=1 zcolumn=VYSKA elevation=dmr slope=slope aspect=aspect pcurvature=curvature_p_rst tcurvature=curvature_t_rst mcurvature=curvature_m tension=40. segmax=40 npmin=300 zscale=1.0
r.flow --overwrite elevation=dmr flowlength=flowlength
r.terraflow --overwrite elevation=dmr filled=filled direction=direction swatershed=swatershed accumulation=accumulation tci=tci memory=300
r.univar -g --overwrite map=geology output=C:\DP_LF\vypocet\info\info_G.txt percentile=90 separator=pipe
r.univar -g --overwrite map=dmr output=C:\DP_LF\vypocet\info\info_DMR.txt percentile=90 separator=pipe
r.univar -g --overwrite map=curvature_m output=C:\DP_LF\vypocet\info\info_K.txt percentile=90 separator=pipe
r.univar -g --overwrite map=flowlength output=C:\DP_LF\vypocet\info\info_DS.txt percentile=90 separator=pipe
r.univar -g --overwrite map=accumulation output=C:\DP_LF\vypocet\info\info_M.txt percentile=90 separator=pipe
r.univar -g --overwrite map=landuse output=C:\DP_LF\vypocet\info\info_VK.txt percentile=90 separator=pipe
r.univar -g --overwrite map=aspect output=C:\DP_LF\vypocet\info\info_E.txt percentile=90 separator=pipe
r.univar -g --overwrite map=slope output=C:\DP_LF\vypocet\info\info_S.txt percentile=90 separator=pipe
r.reclass --overwrite input=geology output=geology_recl1 rules=C:\DP_LF\vypocet\recl1\recl1_G.txt
r.recode --overwrite input=dmr output=dmr_recl1 rules=C:\DP_LF\vypocet\recl1\recl1_DMR.txt
r.recode --overwrite input=slope output=slope_recl1 rules=C:\DP_LF\vypocet\recl1\recl1_S.txt
r.recode --overwrite input=aspect output=aspect_recl1 rules=C:\DP_LF\vypocet\recl1\recl1_E.txt
r.reclass --overwrite input=landuse output=landuse_recl1 rules=C:\DP_LF\vypocet\recl1\recl1_VK.txt
r.recode --overwrite input=flowlength output=flowlength_recl1 rules=C:\DP_LF\vypocet\recl1\recl1_DS.txt
r.recode --overwrite input=accumulation output=accumulation_recl1 rules=C:\DP_LF\vypocet\recl1\recl1_M.txt
r.recode --overwrite input=curvature_m output=curv_m_recl1 rules=C:\DP_LF\vypocet\recl1\recl1_K.txt
r.report -h -n --overwrite map=geology_recl1 units=k,p output=C:\DP_LF\vypocet\report\report_G.txt null_value=* nsteps=255
r.report -h -n --overwrite map=dmr_recl1 units=k,p output=C:\DP_LF\vypocet\report\report_DMR.txt null_value=* nsteps=255
r.report -h -n --overwrite map=slope_recl1 units=k,p output=C:\DP_LF\vypocet\report\report_S.txt null_value=* nsteps=255
r.report -h -n --overwrite map=aspect_recl1 units=k,p output=C:\DP_LF\vypocet\report\report_E.txt null_value=* nsteps=255
r.report -h -n --overwrite map=landuse_recl1 units=k,p output=C:\DP_LF\vypocet\report\report_VK.txt null_value=* nsteps=255
r.report -h -n --overwrite map=flowlength_recl1 units=k,p output=C:\DP_LF\vypocet\report\report_DS.txt null_value=* nsteps=255
r.report -h -n --overwrite map=accumulation_recl1 units=k,p output=C:\DP_LF\vypocet\report\report_M.txt null_value=* nsteps=255
r.report -h -n --overwrite map=curv_m_recl1 units=k,p output=C:\DP_LF\vypocet\report\report_K.txt null_value=* nsteps=255
r.mask --overwrite raster=zosuvy maskcats=* layer=1
r.report -h -n --overwrite map=geology_recl1 units=k,p output=C:\DP_LF\vypocet\report\report_G_z.txt null_value=* nsteps=255
r.report -h -n --overwrite map=dmr_recl1 units=k,p output=C:\DP_LF\vypocet\report\report_DMR_z.txt null_value=* nsteps=255
r.report -h -n --overwrite map=slope_recl1 units=k,p output=C:\DP_LF\vypocet\report\report_S_z.txt null_value=* nsteps=255
r.report -h -n --overwrite map=aspect_recl1 units=k,p output=C:\DP_LF\vypocet\report\report_E_z.txt null_value=* nsteps=255
r.report -h -n --overwrite map=landuse_recl1 units=k,p output=C:\DP_LF\vypocet\report\report_VK_z.txt null_value=* nsteps=255
r.report -h -n --overwrite map=flowlength_recl1 units=k,p output=C:\DP_LF\vypocet\report\report_DS_z.txt null_value=* nsteps=255
r.report -h -n --overwrite map=accumulation_recl1 units=k,p output=C:\DP_LF\vypocet\report\report_M_z.txt null_value=* nsteps=255
r.report -h -n --overwrite map=curv_m_recl1 units=k,p output=C:\DP_LF\vypocet\report\report_K_z.txt null_value=* nsteps=255
r.mask --overwrite raster=zu maskcats=* layer=1
r.reclass --overwrite input=geology output=geology_recl1 rules=C:\DP_LF\vypocet\recl1\recl1_G.txt
r.recode --overwrite input=dmr output=dmr_recl1 rules=C:\DP_LF\vypocet\recl1\recl1_DMR.txt
r.recode --overwrite input=slope output=slope_recl1 rules=C:\DP_LF\vypocet\recl1\recl1_S.txt
r.recode --overwrite input=aspect output=aspect_recl1 rules=C:\DP_LF\vypocet\recl1\recl1_E.txt
r.reclass --overwrite input=landuse output=landuse_recl1 rules=C:\DP_LF\vypocet\recl1\recl1_VK.txt
r.recode --overwrite input=flowlength output=flowlength_recl1 rules=C:\DP_LF\vypocet\recl1\recl1_DS.txt
r.recode --overwrite input=accumulation output=accumulation_recl1 rules=C:\DP_LF\vypocet\recl1\recl1_M.txt
r.recode --overwrite input=curvature_m output=curv_m_recl1 rules=C:\DP_LF\vypocet\recl1\recl1_K.txt
r.report -h -n --overwrite map=geology_recl1 units=k,p output=C:\DP_LF\vypocet\report\report_G.txt null_value=* nsteps=255
r.report -h -n --overwrite map=dmr_recl1 units=k,p output=C:\DP_LF\vypocet\report\report_DMR.txt null_value=* nsteps=255
r.report -h -n --overwrite map=slope_recl1 units=k,p output=C:\DP_LF\vypocet\report\report_S.txt null_value=* nsteps=255
r.report -h -n --overwrite map=aspect_recl1 units=k,p output=C:\DP_LF\vypocet\report\report_E.txt null_value=* nsteps=255
r.report -h -n --overwrite map=landuse_recl1 units=k,p output=C:\DP_LF\vypocet\report\report_VK.txt null_value=* nsteps=255
r.report -h -n --overwrite map=flowlength_recl1 units=k,p output=C:\DP_LF\vypocet\report\report_DS.txt null_value=* nsteps=255
r.report -h -n --overwrite map=accumulation_recl1 units=k,p output=C:\DP_LF\vypocet\report\report_M.txt null_value=* nsteps=255
r.report -h -n --overwrite map=curv_m_recl1 units=k,p output=C:\DP_LF\vypocet\report\report_K.txt null_value=* nsteps=255
r.mask --overwrite raster=zosuvy maskcats=* layer=1
r.report -h -n --overwrite map=geology_recl1 units=k,p output=C:\DP_LF\vypocet\report\report_G_z.txt null_value=* nsteps=255
r.report -h -n --overwrite map=dmr_recl1 units=k,p output=C:\DP_LF\vypocet\report\report_DMR_z.txt null_value=* nsteps=255
r.report -h -n --overwrite map=slope_recl1 units=k,p output=C:\DP_LF\vypocet\report\report_S_z.txt null_value=* nsteps=255
r.report -h -n --overwrite map=aspect_recl1 units=k,p output=C:\DP_LF\vypocet\report\report_E_z.txt null_value=* nsteps=255
r.report -h -n --overwrite map=landuse_recl1 units=k,p output=C:\DP_LF\vypocet\report\report_VK_z.txt null_value=* nsteps=255
r.report -h -n --overwrite map=flowlength_recl1 units=k,p output=C:\DP_LF\vypocet\report\report_DS_z.txt null_value=* nsteps=255
r.report -h -n --overwrite map=accumulation_recl1 units=k,p output=C:\DP_LF\vypocet\report\report_M_z.txt null_value=* nsteps=255
r.report -h -n --overwrite map=curv_m_recl1 units=k,p output=C:\DP_LF\vypocet\report\report_K_z.txt null_value=* nsteps=255
r.mask --overwrite raster=zu maskcats=* layer=1
r.reclass --overwrite input=geology output=geology_recl2 rules=C:\DP_LF\vypocet\recl2\recl2_G.txt
r.reclass --overwrite input=dmr_recl1 output=dmr_recl2 rules=C:\DP_LF\vypocet\recl2\recl2_DMR.txt
r.reclass --overwrite input=slope_recl1 output=slope_recl2 rules=C:\DP_LF\vypocet\recl2\recl2_S.txt
r.reclass --overwrite input=aspect_recl1 output=aspect_recl2 rules=C:\DP_LF\vypocet\recl2\recl2_E.txt
r.reclass --overwrite input=landuse_recl1 output=landuse_recl2 rules=C:\DP_LF\vypocet\recl2\recl2_VK.txt
r.reclass --overwrite input=flowlength_recl1 output=flowlength_recl2 rules=C:\DP_LF\vypocet\recl2\recl2_DS.txt
r.reclass --overwrite input=accumulation_recl1 output=accumulation_recl2 rules=C:\DP_LF\vypocet\recl2\recl2_M.txt
r.reclass --overwrite input=curv_m_recl1 output=curv_m_recl2 rules=C:\DP_LF\vypocet\recl2\recl2_K.txt
r.mapcalc --overwrite file=C:\DP_LF\vypocet\rovnica.txt
r.univar -g --overwrite map=y output=C:\DP_LF\vypocet\info_y.txt percentile=90 separator=pipe
r.quantile -r input=y quantiles=5 bins=1000000
r.colors map=y color=gyr
r.recode --overwrite input=y output=ba rules=C:\DP_LF\vypocet\recl_y.txt
r.reclass --overwrite input=ba output=ba_val345 rules=C:\DP_LF\nastroj\file\validacia345.txt
r.stats -a -n --overwrite input=ba_val345,zosuvy output=C:\DP_LF\vypocet\val_345.txt separator=space null_value=* nsteps=255
r.reclass --overwrite input=ba output=ba_val45 rules=C:\DP_LF\nastroj\file\validacia45.txt
r.stats -a -n --overwrite input=ba_val45,zosuvy output=C:\DP_LF\vypocet\val_45.txt separator=space null_value=* nsteps=255
r.out.png input=y output=C:\DP_LF\vypocet\y.png compression=6
r.colors map=y color=gyr
r.recode --overwrite input=y output=ba rules=C:\DP_LF\vypocet\recl_y.txt
r.reclass --overwrite input=ba output=ba_val345 rules=C:\DP_LF\nastroj\file\validacia345.txt
r.stats -a -n --overwrite input=ba_val345,zosuvy output=C:\DP_LF\vypocet\val_345.txt separator=space null_value=* nsteps=255
r.reclass --overwrite input=ba output=ba_val45 rules=C:\DP_LF\nastroj\file\validacia45.txt
r.stats -a -n --overwrite input=ba_val45,zosuvy output=C:\DP_LF\vypocet\val_45.txt separator=space null_value=* nsteps=255
r.out.png input=y output=C:\DP_LF\vypocet\y.png compression=6
r.colors map=y color=gyr
r.recode --overwrite input=y output=ba rules=C:\DP_LF\vypocet\recl_y.txt
r.reclass --overwrite input=ba output=ba_val345 rules=C:\DP_LF\nastroj\files\validacia345.txt
r.stats -a -n --overwrite input=ba_val345,zosuvy output=C:\DP_LF\vypocet\val_345.txt separator=space null_value=* nsteps=255
r.reclass --overwrite input=ba output=ba_val45 rules=C:\DP_LF\nastroj\files\validacia45.txt
r.stats -a -n --overwrite input=ba_val45,zosuvy output=C:\DP_LF\vypocet\val_45.txt separator=space null_value=* nsteps=255
r.out.png input=y output=C:\DP_LF\vypocet\y.png compression=6
r.colors map=y color=gyr
r.recode --overwrite input=y output=ba rules=C:\DP_LF\vypocet\recl_y.txt
r.reclass --overwrite input=ba output=ba_val345 rules=C:\DP_LF\nastroj\files\validacia345.txt
r.stats -a -n --overwrite input=ba_val345,zosuvy output=C:\DP_LF\vypocet\val_345.txt separator=space null_value=* nsteps=255
r.reclass --overwrite input=ba output=ba_val45 rules=C:\DP_LF\nastroj\files\validacia45.txt
r.stats -a -n --overwrite input=ba_val45,zosuvy output=C:\DP_LF\vypocet\val_45.txt separator=space null_value=* nsteps=255
r.out.png --overwrite input=y output=C:\DP_LF\vypocet\y.png compression=6
r.colors map=y color=gyr
r.recode --overwrite input=y output=ba rules=C:\DP_LF\vypocet\recl_y.txt
r.reclass --overwrite input=ba output=ba_val345 rules=C:\DP_LF\nastroj\files\validacia345.txt
r.stats -a -n --overwrite input=ba_val345,zosuvy output=C:\DP_LF\vypocet\val_345.txt separator=space null_value=* nsteps=255
r.reclass --overwrite input=ba output=ba_val45 rules=C:\DP_LF\nastroj\files\validacia45.txt
r.stats -a -n --overwrite input=ba_val45,zosuvy output=C:\DP_LF\vypocet\val_45.txt separator=space null_value=* nsteps=255
r.out.png --overwrite input=y output=C:\DP_LF\vypocet\y.png compression=6
r.report map=ba@PERMANENT units=h,c,p
r.report map=y@PERMANENT units=h,c,p
g.copy
g.copy --overwrite raster=aspect@PERMANENT,aspect@PM
v.pack --overwrite input=area@PERMANENT output=C:\DP_LF\Mapy\vstup.pack
v.pack --overwrite input=geology@PERMANENT output=C:\DP_LF\Mapy\vstup.pack
v.pack --overwrite input=polohopis@PERMANENT output=C:\DP_LF\Mapy\vstup.pack
v.pack --overwrite input=vyskopis@PERMANENT output=C:\DP_LF\Mapy\vstup.pack
v.pack --overwrite input=zosuvy@PERMANENT output=C:\DP_LF\Mapy\vstup.pack
v.pack input=area output=C:\DP_LF\Mapy\map.pack
v.pack input=geology output=C:\DP_LF\Mapy\map.pack
v.pack input=polohopis output=C:\DP_LF\Mapy\map.pack
v.pack input=vyskopis output=C:\DP_LF\Mapy\map.pack
v.pack input=zosuvy output=C:\DP_LF\Mapy\map.pack
g.remove type=raster map=accumulation_recl2
g.remove -f type=raster map=accumulation_recl2
g.remove -f type=raster name=accumulation_recl2
g.remove -f type=raster name=dmr_recl2,landuse_recl2,slope_recl2,curv_m_recl2,aspect_recl2,geology_recl2
g.remove -f type=raster name=dmr_recl1,landuse_recl1,slope_recl1,curv_m_recl1,aspect_recl1,geology_recl1,accumulation_recl1
g.remove -f type=raster name=y,ba_val345,ba_val45
g.remove -f type=raster name=flowlength_recl2,flowlength_recl1,ba
g.remove -f type=raster name=flowlength_recl1
r.reclass --overwrite input=geology output=geology_recl1 rules=C:\DP_LF\vypocet\recl1\recl1_G.txt
r.recode --overwrite input=dmr output=dmr_recl1 rules=C:\DP_LF\vypocet\recl1\recl1_DMR.txt
r.recode --overwrite input=slope output=slope_recl1 rules=C:\DP_LF\vypocet\recl1\recl1_S.txt
r.recode --overwrite input=aspect output=aspect_recl1 rules=C:\DP_LF\vypocet\recl1\recl1_E.txt
r.reclass --overwrite input=landuse output=landuse_recl1 rules=C:\DP_LF\vypocet\recl1\recl1_VK.txt
r.recode --overwrite input=flowlength output=flowlength_recl1 rules=C:\DP_LF\vypocet\recl1\recl1_DS.txt
r.recode --overwrite input=accumulation output=accumulation_recl1 rules=C:\DP_LF\vypocet\recl1\recl1_M.txt
r.recode --overwrite input=curvature_m output=curv_m_recl1 rules=C:\DP_LF\vypocet\recl1\recl1_K.txt
r.report -h -n --overwrite map=geology_recl1 units=k,p output=C:\DP_LF\vypocet\report\report_G.txt null_value=* nsteps=255
r.report -h -n --overwrite map=dmr_recl1 units=k,p output=C:\DP_LF\vypocet\report\report_DMR.txt null_value=* nsteps=255
r.report -h -n --overwrite map=slope_recl1 units=k,p output=C:\DP_LF\vypocet\report\report_S.txt null_value=* nsteps=255
r.report -h -n --overwrite map=aspect_recl1 units=k,p output=C:\DP_LF\vypocet\report\report_E.txt null_value=* nsteps=255
r.report -h -n --overwrite map=landuse_recl1 units=k,p output=C:\DP_LF\vypocet\report\report_VK.txt null_value=* nsteps=255
r.report -h -n --overwrite map=flowlength_recl1 units=k,p output=C:\DP_LF\vypocet\report\report_DS.txt null_value=* nsteps=255
r.report -h -n --overwrite map=accumulation_recl1 units=k,p output=C:\DP_LF\vypocet\report\report_M.txt null_value=* nsteps=255
r.report -h -n --overwrite map=curv_m_recl1 units=k,p output=C:\DP_LF\vypocet\report\report_K.txt null_value=* nsteps=255
r.mask --overwrite raster=zosuvy maskcats=* layer=1
r.report -h -n --overwrite map=geology_recl1 units=k,p output=C:\DP_LF\vypocet\report\report_G_z.txt null_value=* nsteps=255
r.report -h -n --overwrite map=dmr_recl1 units=k,p output=C:\DP_LF\vypocet\report\report_DMR_z.txt null_value=* nsteps=255
r.report -h -n --overwrite map=slope_recl1 units=k,p output=C:\DP_LF\vypocet\report\report_S_z.txt null_value=* nsteps=255
r.report -h -n --overwrite map=aspect_recl1 units=k,p output=C:\DP_LF\vypocet\report\report_E_z.txt null_value=* nsteps=255
r.report -h -n --overwrite map=landuse_recl1 units=k,p output=C:\DP_LF\vypocet\report\report_VK_z.txt null_value=* nsteps=255
r.report -h -n --overwrite map=flowlength_recl1 units=k,p output=C:\DP_LF\vypocet\report\report_DS_z.txt null_value=* nsteps=255
r.report -h -n --overwrite map=accumulation_recl1 units=k,p output=C:\DP_LF\vypocet\report\report_M_z.txt null_value=* nsteps=255
r.report -h -n --overwrite map=curv_m_recl1 units=k,p output=C:\DP_LF\vypocet\report\report_K_z.txt null_value=* nsteps=255
r.mask --overwrite raster=zu maskcats=* layer=1
r.reclass --overwrite input=geology output=geology_recl2 rules=C:\DP_LF\vypocet\recl2\recl2_G.txt
r.reclass --overwrite input=dmr_recl1 output=dmr_recl2 rules=C:\DP_LF\vypocet\recl2\recl2_DMR.txt
r.reclass --overwrite input=slope_recl1 output=slope_recl2 rules=C:\DP_LF\vypocet\recl2\recl2_S.txt
r.reclass --overwrite input=aspect_recl1 output=aspect_recl2 rules=C:\DP_LF\vypocet\recl2\recl2_E.txt
r.reclass --overwrite input=landuse_recl1 output=landuse_recl2 rules=C:\DP_LF\vypocet\recl2\recl2_VK.txt
r.reclass --overwrite input=flowlength_recl1 output=flowlength_recl2 rules=C:\DP_LF\vypocet\recl2\recl2_DS.txt
r.reclass --overwrite input=accumulation_recl1 output=accumulation_recl2 rules=C:\DP_LF\vypocet\recl2\recl2_M.txt
r.reclass --overwrite input=curv_m_recl1 output=curv_m_recl2 rules=C:\DP_LF\vypocet\recl2\recl2_K.txt
r.mapcalc --overwrite file=C:\DP_LF\vypocet\rovnica.txt
r.univar -g --overwrite map=y output=C:\DP_LF\vypocet\info_y.txt percentile=90 separator=pipe
r.quantile -r input=y quantiles=5 bins=1000000
r.quantile -r --quiet input=y quantiles=-1000000000 percentiles=90 bins=1000000
r.quantile -r --quiet input=y quantiles=-1000000000 percentiles=70 bins=1000000
r.colors -e map=y color=gyr
r.recode --overwrite input=y output=ba rules=C:\DP_LF\vypocet\recl_y.txt title=kategorie
r.out.png -t --overwrite input=y output=C:\DP_LF\vypocet\y.png compression=7
r.recode --overwrite input=y output=ba_val rules=C:\DP_LF\vypocet\recl_val.txt title=validation
r.stats -a -n --overwrite input=ba_val output=C:\DP_LF\vypocet\ba_stats.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,ba_val output=C:\DP_LF\vypocet\val_stats.txt separator=space null_value=* nsteps=255
r.colors -e map=y color=gyr
r.recode --overwrite input=y output=ba rules=C:\DP_LF\vypocet\recl_y.txt title=kategorie
r.out.png -t --overwrite input=y output=C:\DP_LF\vypocet\y.png compression=7
r.recode --overwrite input=y output=ba_val rules=C:\DP_LF\vypocet\recl_val.txt title=validation
r.stats -a -n --overwrite input=ba_val output=C:\DP_LF\vypocet\ba_stats.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,ba_val output=C:\DP_LF\vypocet\val_stats.txt separator=space null_value=* nsteps=255
r.colors -e map=y color=gyr
r.recode --overwrite input=y output=ba rules=C:\DP_LF\vypocet\recl_y.txt title=kategorie
r.out.png -t --overwrite input=y output=C:\DP_LF\vypocet\y.png compression=7
r.recode --overwrite input=y output=ba_val rules=C:\DP_LF\vypocet\recl_val.txt title=validation
r.stats -a -n --overwrite input=ba_val output=C:\DP_LF\vypocet\ba_stats.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,ba_val output=C:\DP_LF\vypocet\val_stats.txt separator=space null_value=* nsteps=255
r.colors -e map=y color=gyr
r.recode --overwrite input=y output=ba rules=C:\DP_LF\vypocet\recl_y.txt title=kategorie
r.out.png -t --overwrite input=y output=C:\DP_LF\vypocet\y.png compression=7
r.recode --overwrite input=y output=ba_val rules=C:\DP_LF\vypocet\recl_val.txt title=validation
r.stats -a -n --overwrite input=ba_val output=C:\DP_LF\vypocet\ba_stats.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,ba_val output=C:\DP_LF\vypocet\val_stats.txt separator=space null_value=* nsteps=255
r.colors -e map=y color=gyr
r.recode --overwrite input=y output=ba rules=C:\DP_LF\vypocet\recl_y.txt title=kategorie
r.out.png -t --overwrite input=y output=C:\DP_LF\vypocet\y.png compression=7
r.recode --overwrite input=y output=ba_val rules=C:\DP_LF\vypocet\recl_val.txt title=validation
r.stats -a -n --overwrite input=ba_val output=C:\DP_LF\vypocet\ba_stats.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,ba_val output=C:\DP_LF\vypocet\val_stats.txt separator=space null_value=* nsteps=255
r.colors -e map=y color=gyr
r.recode --overwrite input=y output=ba rules=C:\DP_LF\vypocet\recl_y.txt title=kategorie
r.out.png -t --overwrite input=y output=C:\DP_LF\vypocet\y.png compression=7
r.recode --overwrite input=y output=ba_val rules=C:\DP_LF\vypocet\recl_val.txt title=validation
r.stats -a -n --overwrite input=ba_val output=C:\DP_LF\vypocet\ba_stats.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,ba_val output=C:\DP_LF\vypocet\val_stats.txt separator=space null_value=* nsteps=255
r.quantile -r input=y quantiles=5 bins=1000000
r.quantile -r --quiet input=y quantiles=-1000000000 percentiles=70 bins=1000000
r.report map=curvature_m@PERMANENT units=h,c,p
r.univar map=curvature_m@PERMANENT
r.recode
r.quantile -r --quiet input=y quantiles=-1000000000 percentiles=40 bins=1000000
r.quantile -r --quiet input=y quantiles=-1000000000 percentiles=60 bins=1000000
r.quantile -r --quiet input=y quantiles=-1000000000 percentiles=80 bins=1000000
r.colors -e map=y color=gyr
r.recode --overwrite input=y output=ba rules=C:\DP_LF\vypocet\recl_y.txt title=kategorie
r.out.png -t --overwrite input=y output=C:\DP_LF\vypocet\y.png compression=7
r.recode --overwrite input=y output=ba_val40 rules=C:\DP_LF\vypocet\recl_val40.txt title=validation
r.stats -a -n --overwrite input=ba_val40 output=C:\DP_LF\vypocet\ba_stats40.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,ba_val40 output=C:\DP_LF\vypocet\val_stats40.txt separator=space null_value=* nsteps=255
r.recode --overwrite input=y output=ba_val60 rules=C:\DP_LF\vypocet\recl_val60.txt
r.stats -a -n --overwrite input=ba_val60 output=C:\DP_LF\vypocet\ba_stats60 separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,ba_val60 output=C:\DP_LF\vypocet\val_stats60 separator=space null_value=* nsteps=255
r.recode --overwrite input=y output=ba_val80 rules=C:\DP_LF\vypocet\recl_val80.txt
r.stats -a -n --overwrite input=ba_val80 output=C:\DP_LF\vypocet\ba_stats80 separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,ba_val80 output=C:\Users\Ludka\val_stats80 separator=space null_value=* nsteps=255
r.colors -e map=y color=gyr
r.recode --overwrite input=y output=ba rules=C:\DP_LF\vypocet\recl_y.txt title=kategorie
r.out.png -t --overwrite input=y output=C:\DP_LF\vypocet\y.png compression=7
r.recode --overwrite input=y output=ba_val40 rules=C:\DP_LF\vypocet\recl_val40.txt title=validation
r.stats -a -n --overwrite input=ba_val40 output=C:\DP_LF\vypocet\ba_stats40.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,ba_val40 output=C:\DP_LF\vypocet\val_stats40.txt separator=space null_value=* nsteps=255
r.recode --overwrite input=y output=ba_val60 rules=C:\DP_LF\vypocet\recl_val60.txt
r.stats -a -n --overwrite input=ba_val60 output=C:\DP_LF\vypocet\ba_stats60.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,ba_val60 output=C:\DP_LF\vypocet\val_stats60.txt separator=space null_value=* nsteps=255
r.recode --overwrite input=y output=ba_val80 rules=C:\DP_LF\vypocet\recl_val80.txt
r.stats -a -n --overwrite input=ba_val80 output=C:\DP_LF\vypocet\ba_stats80.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,ba_val80 output=C:\Users\Ludka\val_stats80.txt separator=space null_value=* nsteps=255
r.colors -e map=y color=gyr
r.recode --overwrite input=y output=ba rules=C:\DP_LF\vypocet\recl_y.txt title=kategorie
r.out.png -t --overwrite input=y output=C:\DP_LF\vypocet\y.png compression=7
r.recode --overwrite input=y output=ba_val40 rules=C:\DP_LF\vypocet\recl_val40.txt title=validation
r.stats -a -n --overwrite input=ba_val40 output=C:\DP_LF\vypocet\ba_stats40.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,ba_val40 output=C:\DP_LF\vypocet\val_stats40.txt separator=space null_value=* nsteps=255
r.recode --overwrite input=y output=ba_val60 rules=C:\DP_LF\vypocet\recl_val60.txt
r.stats -a -n --overwrite input=ba_val60 output=C:\DP_LF\vypocet\ba_stats60.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,ba_val60 output=C:\DP_LF\vypocet\val_stats60.txt separator=space null_value=* nsteps=255
r.recode --overwrite input=y output=ba_val80 rules=C:\DP_LF\vypocet\recl_val80.txt
r.stats -a -n --overwrite input=ba_val80 output=C:\DP_LF\vypocet\ba_stats80.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,ba_val80 output=C:\DP_LF\vypocet\val_stats80.txt separator=space null_value=* nsteps=255
r.colors -e map=y color=gyr
r.recode --overwrite input=y output=ba rules=C:\DP_LF\vypocet\recl_y.txt title=kategorie
r.out.png -t --overwrite input=y output=C:\DP_LF\vypocet\y.png compression=7
r.recode --overwrite input=y output=ba_val40 rules=C:\DP_LF\vypocet\recl_val40.txt title=validation
r.stats -a -n --overwrite input=ba_val40 output=C:\DP_LF\vypocet\ba_stats40.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,ba_val40 output=C:\DP_LF\vypocet\val_stats40.txt separator=space null_value=* nsteps=255
r.recode --overwrite input=y output=ba_val60 rules=C:\DP_LF\vypocet\recl_val60.txt
r.stats -a -n --overwrite input=ba_val60 output=C:\DP_LF\vypocet\ba_stats60.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,ba_val60 output=C:\DP_LF\vypocet\val_stats60.txt separator=space null_value=* nsteps=255
r.recode --overwrite input=y output=ba_val80 rules=C:\DP_LF\vypocet\recl_val80.txt
r.stats -a -n --overwrite input=ba_val80 output=C:\DP_LF\vypocet\ba_stats80.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,ba_val80 output=C:\DP_LF\vypocet\val_stats80.txt separator=space null_value=* nsteps=255
r.colors -e map=y color=gyr
r.recode --overwrite input=y output=ba rules=C:\DP_LF\vypocet\recl_y.txt title=kategorie
r.out.png -t --overwrite input=y output=C:\DP_LF\vypocet\y.png compression=7
r.recode --overwrite input=y output=ba_val40 rules=C:\DP_LF\vypocet\recl_val40.txt title=validation
r.stats -a -n --overwrite input=ba_val40 output=C:\DP_LF\vypocet\ba_stats40.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,ba_val40 output=C:\DP_LF\vypocet\val_stats40.txt separator=space null_value=* nsteps=255
r.recode --overwrite input=y output=ba_val60 rules=C:\DP_LF\vypocet\recl_val60.txt
r.stats -a -n --overwrite input=ba_val60 output=C:\DP_LF\vypocet\ba_stats60.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,ba_val60 output=C:\DP_LF\vypocet\val_stats60.txt separator=space null_value=* nsteps=255
r.recode --overwrite input=y output=ba_val80 rules=C:\DP_LF\vypocet\recl_val80.txt
r.stats -a -n --overwrite input=ba_val80 output=C:\DP_LF\vypocet\ba_stats80.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,ba_val80 output=C:\DP_LF\vypocet\val_stats80.txt separator=space null_value=* nsteps=255
r.quantile -r --quiet input=y quantiles=-1000000000 percentiles=20 bins=1000000
r.quantile -r --quiet input=y quantiles=-1000000000 percentiles=40 bins=1000000
r.quantile -r --quiet input=y quantiles=-1000000000 percentiles=60 bins=1000000
r.colors -e map=y color=gyr
r.recode --overwrite input=y output=ba rules=C:\DP_LF\vypocet\recl_y.txt title=kategorie
r.out.png -t --overwrite input=y output=C:\DP_LF\vypocet\y.png compression=7
r.recode --overwrite input=y output=ba_val40 rules=C:\DP_LF\vypocet\recl_val40.txt title=validation
r.stats -a -n --overwrite input=ba_val40 output=C:\DP_LF\vypocet\ba_stats40.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,ba_val40 output=C:\DP_LF\vypocet\val_stats40.txt separator=space null_value=* nsteps=255
r.recode --overwrite input=y output=ba_val60 rules=C:\DP_LF\vypocet\recl_val60.txt
r.stats -a -n --overwrite input=ba_val60 output=C:\DP_LF\vypocet\ba_stats60.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,ba_val60 output=C:\DP_LF\vypocet\val_stats60.txt separator=space null_value=* nsteps=255
r.recode --overwrite input=y output=ba_val80 rules=C:\DP_LF\vypocet\recl_val80.txt
r.stats -a -n --overwrite input=ba_val80 output=C:\DP_LF\vypocet\ba_stats80.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,ba_val80 output=C:\DP_LF\vypocet\val_stats80.txt separator=space null_value=* nsteps=255
r.colors -e map=y color=gyr
r.recode --overwrite input=y output=ba rules=C:\DP_LF\vypocet\recl_y.txt title=kategorie
r.out.png -t --overwrite input=y output=C:\DP_LF\vypocet\y.png compression=7
r.recode --overwrite input=y output=ba_val40 rules=C:\DP_LF\vypocet\recl_val40.txt title=validation
r.stats -a -n --overwrite input=ba_val40 output=C:\DP_LF\vypocet\ba_stats40.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,ba_val40 output=C:\DP_LF\vypocet\val_stats40.txt separator=space null_value=* nsteps=255
r.recode --overwrite input=y output=ba_val60 rules=C:\DP_LF\vypocet\recl_val60.txt
r.stats -a -n --overwrite input=ba_val60 output=C:\DP_LF\vypocet\ba_stats60.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,ba_val60 output=C:\DP_LF\vypocet\val_stats60.txt separator=space null_value=* nsteps=255
r.recode --overwrite input=y output=ba_val80 rules=C:\DP_LF\vypocet\recl_val80.txt
r.stats -a -n --overwrite input=ba_val80 output=C:\DP_LF\vypocet\ba_stats80.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,ba_val80 output=C:\DP_LF\vypocet\val_stats80.txt separator=space null_value=* nsteps=255
r.colors -e map=y color=gyr
r.recode --overwrite input=y output=ba rules=C:\DP_LF\vypocet\recl_y.txt title=kategorie
r.out.png -t --overwrite input=y output=C:\DP_LF\vypocet\y.png compression=7
r.recode --overwrite input=y output=ba_val40 rules=C:\DP_LF\vypocet\recl_val40.txt title=validation
r.stats -a -n --overwrite input=ba_val40 output=C:\DP_LF\vypocet\ba_stats40.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,ba_val40 output=C:\DP_LF\vypocet\val_stats40.txt separator=space null_value=* nsteps=255
r.recode --overwrite input=y output=ba_val60 rules=C:\DP_LF\vypocet\recl_val60.txt
r.stats -a -n --overwrite input=ba_val60 output=C:\DP_LF\vypocet\ba_stats60.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,ba_val60 output=C:\DP_LF\vypocet\val_stats60.txt separator=space null_value=* nsteps=255
r.recode --overwrite input=y output=ba_val80 rules=C:\DP_LF\vypocet\recl_val80.txt
r.stats -a -n --overwrite input=ba_val80 output=C:\DP_LF\vypocet\ba_stats80.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,ba_val80 output=C:\DP_LF\vypocet\val_stats80.txt separator=space null_value=* nsteps=255
r.report map=ba_val60@PERMANENT units=h,c,p
g.remove -f type=raster name=ba_val
g.remove -f type=raster name=ba_val40,ba_val60,ba_val80
r.colors -e map=y color=gyr
r.recode --overwrite input=y output=ba rules=C:\DP_LF\vypocet\recl_y.txt title=kategorie
r.out.png -t --overwrite input=y output=C:\DP_LF\vypocet\y.png compression=7
r.recode --overwrite input=y output=y_COV1 rules=C:\DP_LF\vypocet\recl_COV1.txt title=validation
r.stats -a -n --overwrite input=y_COV1 output=C:\DP_LF\vypocet\y_stats_COV1.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,ba_val40 output=C:\DP_LF\vypocet\stats_COV1.txt separator=space null_value=* nsteps=255
r.recode --overwrite input=y output=y_COV2 rules=C:\DP_LF\vypocet\y_stats_COV2.txt
r.stats -a -n --overwrite input=y_COV2 output=C:\DP_LF\vypocet\y_stats_COV2.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,ba_val60 output=C:\DP_LF\vypocet\stats_COV2.txt separator=space null_value=* nsteps=255
r.recode --overwrite input=y output=y_COV3 rules=C:\DP_LF\vypocet\recl_COV3.txt
r.stats -a -n --overwrite input=y_COV3 output=C:\DP_LF\vypocet\y_stats_COV3.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,ba_val80 output=C:\DP_LF\vypocet\stats_COV3.txt separator=space null_value=* nsteps=255
r.colors -e map=y color=gyr
r.recode --overwrite input=y output=ba rules=C:\DP_LF\vypocet\recl_y.txt title=kategorie
r.out.png -t --overwrite input=y output=C:\DP_LF\vypocet\y.png compression=7
r.recode --overwrite input=y output=y_COV1 rules=C:\DP_LF\vypocet\recl_COV1.txt title=validation
r.stats -a -n --overwrite input=y_COV1 output=C:\DP_LF\vypocet\y_stats_COV1.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV1 output=C:\DP_LF\vypocet\stats_COV1.txt separator=space null_value=* nsteps=255
r.recode --overwrite input=y output=y_COV2 rules=C:\DP_LF\vypocet\recl_COV2.txt
r.stats -a -n --overwrite input=y_COV2 output=C:\DP_LF\vypocet\y_stats_COV2.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV2 output=C:\DP_LF\vypocet\stats_COV2.txt separator=space null_value=* nsteps=255
r.recode --overwrite input=y output=y_COV3 rules=C:\DP_LF\vypocet\recl_COV3.txt
r.stats -a -n --overwrite input=y_COV3 output=C:\DP_LF\vypocet\y_stats_COV3.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV3 output=C:\DP_LF\vypocet\stats_COV3.txt separator=space null_value=* nsteps=255
r.colors -e map=y color=gyr
r.recode --overwrite input=y output=ba rules=C:\DP_LF\vypocet\recl_y.txt title=kategorie
r.out.png -t --overwrite input=y output=C:\DP_LF\vypocet\y.png compression=7
r.recode --overwrite input=y output=y_COV1 rules=C:\DP_LF\vypocet\recl_COV1.txt title=validation
r.stats -a -n --overwrite input=y_COV1 output=C:\DP_LF\vypocet\y_stats_COV1.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV1 output=C:\DP_LF\vypocet\stats_COV1.txt separator=space null_value=* nsteps=255
r.recode --overwrite input=y output=y_COV2 rules=C:\DP_LF\vypocet\recl_COV2.txt
r.stats -a -n --overwrite input=y_COV2 output=C:\DP_LF\vypocet\y_stats_COV2.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV2 output=C:\DP_LF\vypocet\stats_COV2.txt separator=space null_value=* nsteps=255
r.recode --overwrite input=y output=y_COV3 rules=C:\DP_LF\vypocet\recl_COV3.txt
r.stats -a -n --overwrite input=y_COV3 output=C:\DP_LF\vypocet\y_stats_COV3.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV3 output=C:\DP_LF\vypocet\stats_COV3.txt separator=space null_value=* nsteps=255
v.in.ogr input=C:\grassdata\DATA_zosuvy\vector layer=area output=area geometry=None --overwrite -o
v.in.ogr input=C:\grassdata\DATA_zosuvy\vector layer=trial output=trial geometry=None --overwrite -o
v.in.ogr input=C:\Users\Ludka\Documents\Skola\GISTA\Gista_testovanie_zosuvy\DATA_zosuvy\vector layer=trial output=trial geometry=None --overwrite -o
r.mask
r.mask raster=trial
r.mask --overwrite raster=trial
r.mask --overwrite vector=trial
r.mask
v.to.rast
v.to.rast input=trial output=trial_rst use=attr
v.to.rast input=trial output=trial_rst use=cat
r.mask --overwrite vector=trial_rst
r.mask --overwrite raster=trial_rst
r.report map=MASK@PERMANENT units=h,c,p
r.colors -e map=y color=gyr
r.recode --overwrite input=y output=ba rules=C:\DP_LF\vypocet\recl_y.txt title=kategorie
r.out.png -t --overwrite input=y output=C:\DP_LF\vypocet\y.png compression=7
r.recode --overwrite input=y output=y_COV1 rules=C:\DP_LF\vypocet\recl_COV1.txt title=validation
r.stats -a -n --overwrite input=y_COV1 output=C:\DP_LF\vypocet\y_stats_COV1.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV1 output=C:\DP_LF\vypocet\stats_COV1.txt separator=space null_value=* nsteps=255
r.recode --overwrite input=y output=y_COV2 rules=C:\DP_LF\vypocet\recl_COV2.txt
r.stats -a -n --overwrite input=y_COV2 output=C:\DP_LF\vypocet\y_stats_COV2.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV2 output=C:\DP_LF\vypocet\stats_COV2.txt separator=space null_value=* nsteps=255
r.recode --overwrite input=y output=y_COV3 rules=C:\DP_LF\vypocet\recl_COV3.txt
r.stats -a -n --overwrite input=y_COV3 output=C:\DP_LF\vypocet\y_stats_COV3.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV3 output=C:\DP_LF\vypocet\stats_COV3.txt separator=space null_value=* nsteps=255
r.mask --overwrite raster=zu
r.colors -e map=y color=gyr
r.recode --overwrite input=y output=ba rules=C:\DP_LF\vypocet\recl_y.txt title=kategorie
r.out.png -t --overwrite input=y output=C:\DP_LF\vypocet\y.png compression=7
r.recode --overwrite input=y output=y_COV1 rules=C:\DP_LF\vypocet\recl_COV1.txt title=validation
r.stats -a -n --overwrite input=y_COV1 output=C:\DP_LF\vypocet\y_stats_COV1.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV1 output=C:\DP_LF\vypocet\stats_COV1.txt separator=space null_value=* nsteps=255
r.recode --overwrite input=y output=y_COV2 rules=C:\DP_LF\vypocet\recl_COV2.txt
r.stats -a -n --overwrite input=y_COV2 output=C:\DP_LF\vypocet\y_stats_COV2.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV2 output=C:\DP_LF\vypocet\stats_COV2.txt separator=space null_value=* nsteps=255
r.recode --overwrite input=y output=y_COV3 rules=C:\DP_LF\vypocet\recl_COV3.txt
r.stats -a -n --overwrite input=y_COV3 output=C:\DP_LF\vypocet\y_stats_COV3.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV3 output=C:\DP_LF\vypocet\stats_COV3.txt separator=space null_value=* nsteps=255
r.colors -e map=y color=gyr
r.recode --overwrite input=y output=ba rules=C:\DP_LF\vypocet\recl_y.txt title=kategorie
r.out.png -t --overwrite input=y output=C:\DP_LF\vypocet\y.png compression=7
r.recode --overwrite input=y output=y_COV1 rules=C:\DP_LF\vypocet\recl_COV1.txt title=validation
r.stats -a -n --overwrite input=y_COV1 output=C:\DP_LF\vypocet\y_stats_COV1.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV1 output=C:\DP_LF\vypocet\stats_COV1.txt separator=space null_value=* nsteps=255
r.recode --overwrite input=y output=y_COV2 rules=C:\DP_LF\vypocet\recl_COV2.txt
r.stats -a -n --overwrite input=y_COV2 output=C:\DP_LF\vypocet\y_stats_COV2.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV2 output=C:\DP_LF\vypocet\stats_COV2.txt separator=space null_value=* nsteps=255
r.recode --overwrite input=y output=y_COV3 rules=C:\DP_LF\vypocet\recl_COV3.txt
r.stats -a -n --overwrite input=y_COV3 output=C:\DP_LF\vypocet\y_stats_COV3.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV3 output=C:\DP_LF\vypocet\stats_COV3.txt separator=space null_value=* nsteps=255
r.colors -e map=y color=gyr
r.recode --overwrite input=y output=ba rules=C:\DP_LF\vypocet\recl_y.txt title=kategorie
r.out.png -t --overwrite input=y output=C:\DP_LF\vypocet\y.png compression=7
r.recode --overwrite input=y output=y_COV1 rules=C:\DP_LF\vypocet\recl_COV1.txt title=validation
r.stats -a -n --overwrite input=y_COV1 output=C:\DP_LF\vypocet\y_stats_COV1.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV1 output=C:\DP_LF\vypocet\stats_COV1.txt separator=space null_value=* nsteps=255
r.recode --overwrite input=y output=y_COV2 rules=C:\DP_LF\vypocet\recl_COV2.txt
r.stats -a -n --overwrite input=y_COV2 output=C:\DP_LF\vypocet\y_stats_COV2.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV2 output=C:\DP_LF\vypocet\stats_COV2.txt separator=space null_value=* nsteps=255
r.recode --overwrite input=y output=y_COV3 rules=C:\DP_LF\vypocet\recl_COV3.txt
r.stats -a -n --overwrite input=y_COV3 output=C:\DP_LF\vypocet\y_stats_COV3.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV3 output=C:\DP_LF\vypocet\stats_COV3.txt separator=space null_value=* nsteps=255
r.colors -e map=y color=gyr
r.recode --overwrite input=y output=ba rules=C:\DP_LF\vypocet\recl_y.txt title=kategorie
r.out.png -t --overwrite input=y output=C:\DP_LF\vypocet\y.png compression=7
r.recode --overwrite input=y output=y_COV1 rules=C:\DP_LF\vypocet\recl_COV1.txt title=validation
r.stats -a -n --overwrite input=y_COV1 output=C:\DP_LF\vypocet\y_stats_COV1.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV1 output=C:\DP_LF\vypocet\stats_COV1.txt separator=space null_value=* nsteps=255
r.recode --overwrite input=y output=y_COV2 rules=C:\DP_LF\vypocet\recl_COV2.txt
r.stats -a -n --overwrite input=y_COV2 output=C:\DP_LF\vypocet\y_stats_COV2.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV2 output=C:\DP_LF\vypocet\stats_COV2.txt separator=space null_value=* nsteps=255
r.recode --overwrite input=y output=y_COV3 rules=C:\DP_LF\vypocet\recl_COV3.txt
r.stats -a -n --overwrite input=y_COV3 output=C:\DP_LF\vypocet\y_stats_COV3.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV3 output=C:\DP_LF\vypocet\stats_COV3.txt separator=space null_value=* nsteps=255
r.colors -e map=y color=gyr
r.recode --overwrite input=y output=ba rules=C:\DP_LF\vypocet\recl_y.txt title=kategorie
r.out.png -t --overwrite input=y output=C:\DP_LF\vypocet\y.png compression=7
r.recode --overwrite input=y output=y_COV1 rules=C:\DP_LF\vypocet\recl_COV1.txt title=validation
r.stats -a -n --overwrite input=y_COV1 output=C:\DP_LF\vypocet\y_stats_COV1.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV1 output=C:\DP_LF\vypocet\stats_COV1.txt separator=space null_value=* nsteps=255
r.recode --overwrite input=y output=y_COV2 rules=C:\DP_LF\vypocet\recl_COV2.txt
r.stats -a -n --overwrite input=y_COV2 output=C:\DP_LF\vypocet\y_stats_COV2.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV2 output=C:\DP_LF\vypocet\stats_COV2.txt separator=space null_value=* nsteps=255
r.recode --overwrite input=y output=y_COV3 rules=C:\DP_LF\vypocet\recl_COV3.txt
r.stats -a -n --overwrite input=y_COV3 output=C:\DP_LF\vypocet\y_stats_COV3.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV3 output=C:\DP_LF\vypocet\stats_COV3.txt separator=space null_value=* nsteps=255
r.colors -e map=y color=gyr
r.recode --overwrite input=y output=ba rules=C:\DP_LF\vypocet\recl_y.txt title=kategorie
r.out.png -t --overwrite input=y output=C:\DP_LF\vypocet\y.png compression=7
r.recode --overwrite input=y output=y_COV1 rules=C:\DP_LF\vypocet\recl_COV1.txt title=validation
r.stats -a -n --overwrite input=y_COV1 output=C:\DP_LF\vypocet\y_stats_COV1.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV1 output=C:\DP_LF\vypocet\stats_COV1.txt separator=space null_value=* nsteps=255
r.recode --overwrite input=y output=y_COV2 rules=C:\DP_LF\vypocet\recl_COV2.txt
r.stats -a -n --overwrite input=y_COV2 output=C:\DP_LF\vypocet\y_stats_COV2.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV2 output=C:\DP_LF\vypocet\stats_COV2.txt separator=space null_value=* nsteps=255
r.recode --overwrite input=y output=y_COV3 rules=C:\DP_LF\vypocet\recl_COV3.txt
r.stats -a -n --overwrite input=y_COV3 output=C:\DP_LF\vypocet\y_stats_COV3.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV3 output=C:\DP_LF\vypocet\stats_COV3.txt separator=space null_value=* nsteps=255
r.colors -e map=y color=gyr
r.recode --overwrite input=y output=ba rules=C:\DP_LF\vypocet\recl_y.txt title=kategorie
r.out.png -t --overwrite input=y output=C:\DP_LF\vypocet\y.png compression=7
r.recode --overwrite input=y output=y_COV1 rules=C:\DP_LF\vypocet\recl_COV1.txt title=validation
r.stats -a -n --overwrite input=y_COV1 output=C:\DP_LF\vypocet\y_stats_COV1.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV1 output=C:\DP_LF\vypocet\stats_COV1.txt separator=space null_value=* nsteps=255
r.recode --overwrite input=y output=y_COV2 rules=C:\DP_LF\vypocet\recl_COV2.txt
r.stats -a -n --overwrite input=y_COV2 output=C:\DP_LF\vypocet\y_stats_COV2.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV2 output=C:\DP_LF\vypocet\stats_COV2.txt separator=space null_value=* nsteps=255
r.recode --overwrite input=y output=y_COV3 rules=C:\DP_LF\vypocet\recl_COV3.txt
r.stats -a -n --overwrite input=y_COV3 output=C:\DP_LF\vypocet\y_stats_COV3.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV3 output=C:\DP_LF\vypocet\stats_COV3.txt separator=space null_value=* nsteps=255
r.colors -e map=y color=gyr
r.recode --overwrite input=y output=ba rules=C:\DP_LF\vypocet\recl_y.txt title=kategorie
r.out.png -t --overwrite input=y output=C:\DP_LF\vypocet\y.png compression=7
r.recode --overwrite input=y output=y_COV1 rules=C:\DP_LF\vypocet\recl_COV1.txt title=validation
r.stats -a -n --overwrite input=y_COV1 output=C:\DP_LF\vypocet\y_stats_COV1.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV1 output=C:\DP_LF\vypocet\stats_COV1.txt separator=space null_value=* nsteps=255
r.recode --overwrite input=y output=y_COV2 rules=C:\DP_LF\vypocet\recl_COV2.txt
r.stats -a -n --overwrite input=y_COV2 output=C:\DP_LF\vypocet\y_stats_COV2.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV2 output=C:\DP_LF\vypocet\stats_COV2.txt separator=space null_value=* nsteps=255
r.recode --overwrite input=y output=y_COV3 rules=C:\DP_LF\vypocet\recl_COV3.txt
r.stats -a -n --overwrite input=y_COV3 output=C:\DP_LF\vypocet\y_stats_COV3.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV3 output=C:\DP_LF\vypocet\stats_COV3.txt separator=space null_value=* nsteps=255
r.colors -e map=y color=gyr
r.recode --overwrite input=y output=ba rules=C:\DP_LF\vypocet\recl_y.txt title=kategorie
r.out.png -t --overwrite input=y output=C:\DP_LF\vypocet\y.png compression=7
r.recode --overwrite input=y output=y_COV1 rules=C:\DP_LF\vypocet\recl_COV1.txt title=validation
r.stats -a -n --overwrite input=y_COV1 output=C:\DP_LF\vypocet\y_stats_COV1.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV1 output=C:\DP_LF\vypocet\stats_COV1.txt separator=space null_value=* nsteps=255
r.recode --overwrite input=y output=y_COV2 rules=C:\DP_LF\vypocet\recl_COV2.txt
r.stats -a -n --overwrite input=y_COV2 output=C:\DP_LF\vypocet\y_stats_COV2.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV2 output=C:\DP_LF\vypocet\stats_COV2.txt separator=space null_value=* nsteps=255
r.recode --overwrite input=y output=y_COV3 rules=C:\DP_LF\vypocet\recl_COV3.txt
r.stats -a -n --overwrite input=y_COV3 output=C:\DP_LF\vypocet\y_stats_COV3.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV3 output=C:\DP_LF\vypocet\stats_COV3.txt separator=space null_value=* nsteps=255
r.colors -e map=y color=gyr
r.recode --overwrite input=y output=ba rules=C:\DP_LF\vypocet\recl_y.txt title=kategorie
r.out.png -t --overwrite input=y output=C:\DP_LF\vypocet\y.png compression=7
r.recode --overwrite input=y output=y_COV1 rules=C:\DP_LF\vypocet\recl_COV1.txt title=validation
r.stats -a -n --overwrite input=y_COV1 output=C:\DP_LF\vypocet\y_stats_COV1.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV1 output=C:\DP_LF\vypocet\stats_COV1.txt separator=space null_value=* nsteps=255
r.recode --overwrite input=y output=y_COV2 rules=C:\DP_LF\vypocet\recl_COV2.txt
r.stats -a -n --overwrite input=y_COV2 output=C:\DP_LF\vypocet\y_stats_COV2.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV2 output=C:\DP_LF\vypocet\stats_COV2.txt separator=space null_value=* nsteps=255
r.recode --overwrite input=y output=y_COV3 rules=C:\DP_LF\vypocet\recl_COV3.txt
r.stats -a -n --overwrite input=y_COV3 output=C:\DP_LF\vypocet\y_stats_COV3.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV3 output=C:\DP_LF\vypocet\stats_COV3.txt separator=space null_value=* nsteps=255
r.colors -e map=y color=gyr
r.recode --overwrite input=y output=ba rules=C:\DP_LF\vypocet\recl_y.txt title=kategorie
r.out.png -t --overwrite input=y output=C:\DP_LF\vypocet\y.png compression=7
r.recode --overwrite input=y output=y_COV1 rules=C:\DP_LF\vypocet\recl_COV1.txt title=validation
r.stats -a -n --overwrite input=y_COV1 output=C:\DP_LF\vypocet\y_stats_COV1.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV1 output=C:\DP_LF\vypocet\stats_COV1.txt separator=space null_value=* nsteps=255
r.recode --overwrite input=y output=y_COV2 rules=C:\DP_LF\vypocet\recl_COV2.txt
r.stats -a -n --overwrite input=y_COV2 output=C:\DP_LF\vypocet\y_stats_COV2.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV2 output=C:\DP_LF\vypocet\stats_COV2.txt separator=space null_value=* nsteps=255
r.recode --overwrite input=y output=y_COV3 rules=C:\DP_LF\vypocet\recl_COV3.txt
r.stats -a -n --overwrite input=y_COV3 output=C:\DP_LF\vypocet\y_stats_COV3.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV3 output=C:\DP_LF\vypocet\stats_COV3.txt separator=space null_value=* nsteps=255
r.colors -e map=y color=gyr
r.recode --overwrite input=y output=ba rules=C:\DP_LF\vypocet\recl_y.txt title=kategorie
r.out.png -t --overwrite input=y output=C:\DP_LF\vypocet\y.png compression=7
r.recode --overwrite input=y output=y_COV1 rules=C:\DP_LF\vypocet\recl_COV1.txt title=validation
r.stats -a -n --overwrite input=y_COV1 output=C:\DP_LF\vypocet\y_stats_COV1.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV1 output=C:\DP_LF\vypocet\stats_COV1.txt separator=space null_value=* nsteps=255
r.recode --overwrite input=y output=y_COV2 rules=C:\DP_LF\vypocet\recl_COV2.txt
r.stats -a -n --overwrite input=y_COV2 output=C:\DP_LF\vypocet\y_stats_COV2.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV2 output=C:\DP_LF\vypocet\stats_COV2.txt separator=space null_value=* nsteps=255
r.recode --overwrite input=y output=y_COV3 rules=C:\DP_LF\vypocet\recl_COV3.txt
r.stats -a -n --overwrite input=y_COV3 output=C:\DP_LF\vypocet\y_stats_COV3.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV3 output=C:\DP_LF\vypocet\stats_COV3.txt separator=space null_value=* nsteps=255
r.colors -e map=y color=gyr
r.recode --overwrite input=y output=ba rules=C:\DP_LF\vypocet\recl_y.txt title=kategorie
r.out.png -t --overwrite input=y output=C:\DP_LF\vypocet\y.png compression=7
r.recode --overwrite input=y output=y_COV1 rules=C:\DP_LF\vypocet\recl_COV1.txt title=validation
r.stats -a -n --overwrite input=y_COV1 output=C:\DP_LF\vypocet\y_stats_COV1.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV1 output=C:\DP_LF\vypocet\stats_COV1.txt separator=space null_value=* nsteps=255
r.recode --overwrite input=y output=y_COV2 rules=C:\DP_LF\vypocet\recl_COV2.txt
r.stats -a -n --overwrite input=y_COV2 output=C:\DP_LF\vypocet\y_stats_COV2.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV2 output=C:\DP_LF\vypocet\stats_COV2.txt separator=space null_value=* nsteps=255
r.recode --overwrite input=y output=y_COV3 rules=C:\DP_LF\vypocet\recl_COV3.txt
r.stats -a -n --overwrite input=y_COV3 output=C:\DP_LF\vypocet\y_stats_COV3.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV3 output=C:\DP_LF\vypocet\stats_COV3.txt separator=space null_value=* nsteps=255
r.colors -e map=y color=gyr
r.recode --overwrite input=y output=ba rules=C:\DP_LF\vypocet\recl_y.txt title=kategorie
r.out.png -t --overwrite input=y output=C:\DP_LF\vypocet\y.png compression=7
r.recode --overwrite input=y output=y_COV1 rules=C:\DP_LF\vypocet\recl_COV1.txt title=validation
r.stats -a -n --overwrite input=y_COV1 output=C:\DP_LF\vypocet\y_stats_COV1.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV1 output=C:\DP_LF\vypocet\stats_COV1.txt separator=space null_value=* nsteps=255
r.recode --overwrite input=y output=y_COV2 rules=C:\DP_LF\vypocet\recl_COV2.txt
r.stats -a -n --overwrite input=y_COV2 output=C:\DP_LF\vypocet\y_stats_COV2.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV2 output=C:\DP_LF\vypocet\stats_COV2.txt separator=space null_value=* nsteps=255
r.recode --overwrite input=y output=y_COV3 rules=C:\DP_LF\vypocet\recl_COV3.txt
r.stats -a -n --overwrite input=y_COV3 output=C:\DP_LF\vypocet\y_stats_COV3.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV3 output=C:\DP_LF\vypocet\stats_COV3.txt separator=space null_value=* nsteps=255
r.colors -e map=y color=gyr
r.recode --overwrite input=y output=ba rules=C:\DP_LF\vypocet\recl_y.txt title=kategorie
r.out.png -t --overwrite input=y output=C:\DP_LF\vypocet\y.png compression=7
r.recode --overwrite input=y output=y_COV1 rules=C:\DP_LF\vypocet\recl_COV1.txt title=validation
r.stats -a -n --overwrite input=y_COV1 output=C:\DP_LF\vypocet\y_stats_COV1.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV1 output=C:\DP_LF\vypocet\stats_COV1.txt separator=space null_value=* nsteps=255
r.recode --overwrite input=y output=y_COV2 rules=C:\DP_LF\vypocet\recl_COV2.txt
r.stats -a -n --overwrite input=y_COV2 output=C:\DP_LF\vypocet\y_stats_COV2.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV2 output=C:\DP_LF\vypocet\stats_COV2.txt separator=space null_value=* nsteps=255
r.recode --overwrite input=y output=y_COV3 rules=C:\DP_LF\vypocet\recl_COV3.txt
r.stats -a -n --overwrite input=y_COV3 output=C:\DP_LF\vypocet\y_stats_COV3.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV3 output=C:\DP_LF\vypocet\stats_COV3.txt separator=space null_value=* nsteps=255
r.colors -e map=y color=gyr
r.recode --overwrite input=y output=ba rules=C:\DP_LF\vypocet\recl_y.txt title=kategorie
r.out.png -t --overwrite input=y output=C:\DP_LF\vypocet\y.png compression=7
r.recode --overwrite input=y output=y_COV1 rules=C:\DP_LF\vypocet\recl_COV1.txt title=validation
r.stats -a -n --overwrite input=y_COV1 output=C:\DP_LF\vypocet\y_stats_COV1.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV1 output=C:\DP_LF\vypocet\stats_COV1.txt separator=space null_value=* nsteps=255
r.recode --overwrite input=y output=y_COV2 rules=C:\DP_LF\vypocet\recl_COV2.txt
r.stats -a -n --overwrite input=y_COV2 output=C:\DP_LF\vypocet\y_stats_COV2.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV2 output=C:\DP_LF\vypocet\stats_COV2.txt separator=space null_value=* nsteps=255
r.recode --overwrite input=y output=y_COV3 rules=C:\DP_LF\vypocet\recl_COV3.txt
r.stats -a -n --overwrite input=y_COV3 output=C:\DP_LF\vypocet\y_stats_COV3.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV3 output=C:\DP_LF\vypocet\stats_COV3.txt separator=space null_value=* nsteps=255
r.colors -e map=y color=gyr
r.recode --overwrite input=y output=ba rules=C:\DP_LF\vypocet\recl_y.txt title=kategorie
r.out.png -t --overwrite input=y output=C:\DP_LF\vypocet\y.png compression=7
r.recode --overwrite input=y output=y_COV1 rules=C:\DP_LF\vypocet\recl_COV1.txt title=validation
r.stats -a -n --overwrite input=y_COV1 output=C:\DP_LF\vypocet\y_stats_COV1.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV1 output=C:\DP_LF\vypocet\stats_COV1.txt separator=space null_value=* nsteps=255
r.recode --overwrite input=y output=y_COV2 rules=C:\DP_LF\vypocet\recl_COV2.txt
r.stats -a -n --overwrite input=y_COV2 output=C:\DP_LF\vypocet\y_stats_COV2.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV2 output=C:\DP_LF\vypocet\stats_COV2.txt separator=space null_value=* nsteps=255
r.recode --overwrite input=y output=y_COV3 rules=C:\DP_LF\vypocet\recl_COV3.txt
r.stats -a -n --overwrite input=y_COV3 output=C:\DP_LF\vypocet\y_stats_COV3.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV3 output=C:\DP_LF\vypocet\stats_COV3.txt separator=space null_value=* nsteps=255
r.colors -e map=y color=gyr
r.recode --overwrite input=y output=ba rules=C:\DP_LF\vypocet\recl_y.txt title=kategorie
r.out.png -t --overwrite input=y output=C:\DP_LF\vypocet\y.png compression=7
r.recode --overwrite input=y output=y_COV1 rules=C:\DP_LF\vypocet\recl_COV1.txt title=validation
r.stats -a -n --overwrite input=y_COV1 output=C:\DP_LF\vypocet\y_stats_COV1.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV1 output=C:\DP_LF\vypocet\stats_COV1.txt separator=space null_value=* nsteps=255
r.recode --overwrite input=y output=y_COV2 rules=C:\DP_LF\vypocet\recl_COV2.txt
r.stats -a -n --overwrite input=y_COV2 output=C:\DP_LF\vypocet\y_stats_COV2.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV2 output=C:\DP_LF\vypocet\stats_COV2.txt separator=space null_value=* nsteps=255
r.recode --overwrite input=y output=y_COV3 rules=C:\DP_LF\vypocet\recl_COV3.txt
r.stats -a -n --overwrite input=y_COV3 output=C:\DP_LF\vypocet\y_stats_COV3.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV3 output=C:\DP_LF\vypocet\stats_COV3.txt separator=space null_value=* nsteps=255
r.colors -e map=y color=gyr
r.recode --overwrite input=y output=ba rules=C:\DP_LF\vypocet\recl_y.txt title=kategorie
r.out.png -t --overwrite input=y output=C:\DP_LF\vypocet\y.png compression=7
r.recode --overwrite input=y output=y_COV1 rules=C:\DP_LF\vypocet\recl_COV1.txt title=validation
r.stats -a -n --overwrite input=y_COV1 output=C:\DP_LF\vypocet\y_stats_COV1.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV1 output=C:\DP_LF\vypocet\stats_COV1.txt separator=space null_value=* nsteps=255
r.recode --overwrite input=y output=y_COV2 rules=C:\DP_LF\vypocet\recl_COV2.txt
r.stats -a -n --overwrite input=y_COV2 output=C:\DP_LF\vypocet\y_stats_COV2.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV2 output=C:\DP_LF\vypocet\stats_COV2.txt separator=space null_value=* nsteps=255
r.recode --overwrite input=y output=y_COV3 rules=C:\DP_LF\vypocet\recl_COV3.txt
r.stats -a -n --overwrite input=y_COV3 output=C:\DP_LF\vypocet\y_stats_COV3.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV3 output=C:\DP_LF\vypocet\stats_COV3.txt separator=space null_value=* nsteps=255
r.colors -e map=y color=gyr
r.recode --overwrite input=y output=ba rules=C:\DP_LF\vypocet\recl_y.txt title=kategorie
r.out.png -t --overwrite input=y output=C:\DP_LF\vypocet\y.png compression=7
r.recode --overwrite input=y output=y_COV1 rules=C:\DP_LF\vypocet\recl_COV1.txt title=validation
r.stats -a -n --overwrite input=y_COV1 output=C:\DP_LF\vypocet\y_stats_COV1.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV1 output=C:\DP_LF\vypocet\stats_COV1.txt separator=space null_value=* nsteps=255
r.recode --overwrite input=y output=y_COV2 rules=C:\DP_LF\vypocet\recl_COV2.txt
r.stats -a -n --overwrite input=y_COV2 output=C:\DP_LF\vypocet\y_stats_COV2.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV2 output=C:\DP_LF\vypocet\stats_COV2.txt separator=space null_value=* nsteps=255
r.recode --overwrite input=y output=y_COV3 rules=C:\DP_LF\vypocet\recl_COV3.txt
r.stats -a -n --overwrite input=y_COV3 output=C:\DP_LF\vypocet\y_stats_COV3.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV3 output=C:\DP_LF\vypocet\stats_COV3.txt separator=space null_value=* nsteps=255
r.colors -e map=y color=gyr
r.recode --overwrite input=y output=ba rules=C:\DP_LF\vypocet\recl_y.txt title=kategorie
r.out.png -t --overwrite input=y output=C:\DP_LF\vypocet\y.png compression=7
r.recode --overwrite input=y output=y_COV1 rules=C:\DP_LF\vypocet\recl_COV1.txt title=validation
r.stats -a -n --overwrite input=y_COV1 output=C:\DP_LF\vypocet\y_stats_COV1.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV1 output=C:\DP_LF\vypocet\stats_COV1.txt separator=space null_value=* nsteps=255
r.recode --overwrite input=y output=y_COV2 rules=C:\DP_LF\vypocet\recl_COV2.txt
r.stats -a -n --overwrite input=y_COV2 output=C:\DP_LF\vypocet\y_stats_COV2.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV2 output=C:\DP_LF\vypocet\stats_COV2.txt separator=space null_value=* nsteps=255
r.recode --overwrite input=y output=y_COV3 rules=C:\DP_LF\vypocet\recl_COV3.txt
r.stats -a -n --overwrite input=y_COV3 output=C:\DP_LF\vypocet\y_stats_COV3.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV3 output=C:\DP_LF\vypocet\stats_COV3.txt separator=space null_value=* nsteps=255
r.colors -e map=y color=gyr
r.recode --overwrite input=y output=ba rules=C:\DP_LF\vypocet\recl_y.txt title=kategorie
r.out.png -t --overwrite input=y output=C:\DP_LF\vypocet\y.png compression=7
r.recode --overwrite input=y output=y_COV1 rules=C:\DP_LF\vypocet\recl_COV1.txt title=validation
r.stats -a -n --overwrite input=y_COV1 output=C:\DP_LF\vypocet\y_stats_COV1.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV1 output=C:\DP_LF\vypocet\stats_COV1.txt separator=space null_value=* nsteps=255
r.recode --overwrite input=y output=y_COV2 rules=C:\DP_LF\vypocet\recl_COV2.txt
r.stats -a -n --overwrite input=y_COV2 output=C:\DP_LF\vypocet\y_stats_COV2.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV2 output=C:\DP_LF\vypocet\stats_COV2.txt separator=space null_value=* nsteps=255
r.recode --overwrite input=y output=y_COV3 rules=C:\DP_LF\vypocet\recl_COV3.txt
r.stats -a -n --overwrite input=y_COV3 output=C:\DP_LF\vypocet\y_stats_COV3.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV3 output=C:\DP_LF\vypocet\stats_COV3.txt separator=space null_value=* nsteps=255
r.colors -e map=y color=gyr
r.recode --overwrite input=y output=ba rules=C:\DP_LF\vypocet\recl_y.txt title=kategorie
r.out.png -t --overwrite input=y output=C:\DP_LF\vypocet\y.png compression=7
r.recode --overwrite input=y output=y_COV1 rules=C:\DP_LF\vypocet\recl_COV1.txt title=validation
r.stats -a -n --overwrite input=y_COV1 output=C:\DP_LF\vypocet\y_stats_COV1.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV1 output=C:\DP_LF\vypocet\stats_COV1.txt separator=space null_value=* nsteps=255
r.recode --overwrite input=y output=y_COV2 rules=C:\DP_LF\vypocet\recl_COV2.txt
r.stats -a -n --overwrite input=y_COV2 output=C:\DP_LF\vypocet\y_stats_COV2.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV2 output=C:\DP_LF\vypocet\stats_COV2.txt separator=space null_value=* nsteps=255
r.recode --overwrite input=y output=y_COV3 rules=C:\DP_LF\vypocet\recl_COV3.txt
r.stats -a -n --overwrite input=y_COV3 output=C:\DP_LF\vypocet\y_stats_COV3.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV3 output=C:\DP_LF\vypocet\stats_COV3.txt separator=space null_value=* nsteps=255
r.report map=ba@PERMANENT units=h,c,p
r.quantile -r input=y quantiles=5 bins=1000000
r.colors -e map=y color=gyr
r.recode --overwrite input=y output=ba rules=C:\DP_LF\vypocet\recl_y.txt title=kategorie
r.out.png -t --overwrite input=y output=C:\DP_LF\vypocet\y.png compression=7
r.recode --overwrite input=y output=y_COV1 rules=C:\DP_LF\vypocet\recl_COV1.txt title=validation
r.stats -a -n --overwrite input=y_COV1 output=C:\DP_LF\vypocet\y_stats_COV1.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV1 output=C:\DP_LF\vypocet\stats_COV1.txt separator=space null_value=* nsteps=255
r.recode --overwrite input=y output=y_COV2 rules=C:\DP_LF\vypocet\recl_COV2.txt
r.stats -a -n --overwrite input=y_COV2 output=C:\DP_LF\vypocet\y_stats_COV2.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV2 output=C:\DP_LF\vypocet\stats_COV2.txt separator=space null_value=* nsteps=255
r.recode --overwrite input=y output=y_COV3 rules=C:\DP_LF\vypocet\recl_COV3.txt
r.stats -a -n --overwrite input=y_COV3 output=C:\DP_LF\vypocet\y_stats_COV3.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV3 output=C:\DP_LF\vypocet\stats_COV3.txt separator=space null_value=* nsteps=255
r.colors -e map=y color=gyr
r.recode --overwrite input=y output=ba rules=C:\DP_LF\vypocet\recl_y.txt title=kategorie
r.out.png -t --overwrite input=y output=C:\DP_LF\vypocet\y.png compression=7
r.recode --overwrite input=y output=y_COV1 rules=C:\DP_LF\vypocet\recl_COV1.txt title=validation
r.stats -a -n --overwrite input=y_COV1 output=C:\DP_LF\vypocet\y_stats_COV1.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV1 output=C:\DP_LF\vypocet\stats_COV1.txt separator=space null_value=* nsteps=255
r.recode --overwrite input=y output=y_COV2 rules=C:\DP_LF\vypocet\recl_COV2.txt
r.stats -a -n --overwrite input=y_COV2 output=C:\DP_LF\vypocet\y_stats_COV2.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV2 output=C:\DP_LF\vypocet\stats_COV2.txt separator=space null_value=* nsteps=255
r.recode --overwrite input=y output=y_COV3 rules=C:\DP_LF\vypocet\recl_COV3.txt
r.stats -a -n --overwrite input=y_COV3 output=C:\DP_LF\vypocet\y_stats_COV3.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV3 output=C:\DP_LF\vypocet\stats_COV3.txt separator=space null_value=* nsteps=255
r.colors -e map=y color=gyr
r.recode --overwrite input=y output=ba rules=C:\DP_LF\vypocet\recl_y.txt title=kategorie
r.out.png -t --overwrite input=y output=C:\DP_LF\vypocet\y.png compression=7
r.recode --overwrite input=y output=y_COV1 rules=C:\DP_LF\vypocet\recl_COV1.txt title=validation
r.stats -a -n --overwrite input=y_COV1 output=C:\DP_LF\vypocet\y_stats_COV1.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV1 output=C:\DP_LF\vypocet\stats_COV1.txt separator=space null_value=* nsteps=255
r.recode --overwrite input=y output=y_COV2 rules=C:\DP_LF\vypocet\recl_COV2.txt
r.stats -a -n --overwrite input=y_COV2 output=C:\DP_LF\vypocet\y_stats_COV2.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV2 output=C:\DP_LF\vypocet\stats_COV2.txt separator=space null_value=* nsteps=255
r.recode --overwrite input=y output=y_COV3 rules=C:\DP_LF\vypocet\recl_COV3.txt
r.stats -a -n --overwrite input=y_COV3 output=C:\DP_LF\vypocet\y_stats_COV3.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV3 output=C:\DP_LF\vypocet\stats_COV3.txt separator=space null_value=* nsteps=255
r.colors -e map=y color=gyr
r.recode --overwrite input=y output=ba rules=C:\DP_LF\vypocet\recl_y.txt title=kategorie
r.out.png -t --overwrite input=y output=C:\DP_LF\vypocet\y.png compression=7
r.recode --overwrite input=y output=y_COV1 rules=C:\DP_LF\vypocet\recl_COV1.txt title=validation
r.stats -a -n --overwrite input=y_COV1 output=C:\DP_LF\vypocet\y_stats_COV1.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV1 output=C:\DP_LF\vypocet\stats_COV1.txt separator=space null_value=* nsteps=255
r.recode --overwrite input=y output=y_COV2 rules=C:\DP_LF\vypocet\recl_COV2.txt
r.stats -a -n --overwrite input=y_COV2 output=C:\DP_LF\vypocet\y_stats_COV2.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV2 output=C:\DP_LF\vypocet\stats_COV2.txt separator=space null_value=* nsteps=255
r.recode --overwrite input=y output=y_COV3 rules=C:\DP_LF\vypocet\recl_COV3.txt
r.stats -a -n --overwrite input=y_COV3 output=C:\DP_LF\vypocet\y_stats_COV3.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV3 output=C:\DP_LF\vypocet\stats_COV3.txt separator=space null_value=* nsteps=255
r.colors -e map=y color=gyr
r.recode --overwrite input=y output=ba rules=C:\DP_LF\vypocet\recl_y.txt title=kategorie
r.out.png -t --overwrite input=y output=C:\DP_LF\vypocet\y.png compression=7
r.recode --overwrite input=y output=y_COV1 rules=C:\DP_LF\vypocet\recl_COV1.txt title=validation
r.stats -a -n --overwrite input=y_COV1 output=C:\DP_LF\vypocet\y_stats_COV1.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV1 output=C:\DP_LF\vypocet\stats_COV1.txt separator=space null_value=* nsteps=255
r.recode --overwrite input=y output=y_COV2 rules=C:\DP_LF\vypocet\recl_COV2.txt
r.stats -a -n --overwrite input=y_COV2 output=C:\DP_LF\vypocet\y_stats_COV2.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV2 output=C:\DP_LF\vypocet\stats_COV2.txt separator=space null_value=* nsteps=255
r.recode --overwrite input=y output=y_COV3 rules=C:\DP_LF\vypocet\recl_COV3.txt
r.stats -a -n --overwrite input=y_COV3 output=C:\DP_LF\vypocet\y_stats_COV3.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV3 output=C:\DP_LF\vypocet\stats_COV3.txt separator=space null_value=* nsteps=255
r.colors -e map=y color=gyr
r.recode --overwrite input=y output=ba rules=C:\DP_LF\vypocet\recl_y.txt title=kategorie
r.out.png -t --overwrite input=y output=C:\DP_LF\vypocet\y.png compression=7
r.recode --overwrite input=y output=y_COV1 rules=C:\DP_LF\vypocet\recl_COV1.txt title=validation
r.stats -a -n --overwrite input=y_COV1 output=C:\DP_LF\vypocet\y_stats_COV1.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV1 output=C:\DP_LF\vypocet\stats_COV1.txt separator=space null_value=* nsteps=255
r.recode --overwrite input=y output=y_COV2 rules=C:\DP_LF\vypocet\recl_COV2.txt
r.stats -a -n --overwrite input=y_COV2 output=C:\DP_LF\vypocet\y_stats_COV2.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV2 output=C:\DP_LF\vypocet\stats_COV2.txt separator=space null_value=* nsteps=255
r.recode --overwrite input=y output=y_COV3 rules=C:\DP_LF\vypocet\recl_COV3.txt
r.stats -a -n --overwrite input=y_COV3 output=C:\DP_LF\vypocet\y_stats_COV3.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV3 output=C:\DP_LF\vypocet\stats_COV3.txt separator=space null_value=* nsteps=255
r.colors -e map=y color=gyr
r.recode --overwrite input=y output=ba rules=C:\DP_LF\vypocet\recl_y.txt title=kategorie
r.out.png -t --overwrite input=y output=C:\DP_LF\vypocet\y.png compression=7
r.recode --overwrite input=y output=y_COV1 rules=C:\DP_LF\vypocet\recl_COV1.txt title=validation
r.stats -a -n --overwrite input=y_COV1 output=C:\DP_LF\vypocet\y_stats_COV1.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV1 output=C:\DP_LF\vypocet\stats_COV1.txt separator=space null_value=* nsteps=255
r.recode --overwrite input=y output=y_COV2 rules=C:\DP_LF\vypocet\recl_COV2.txt
r.stats -a -n --overwrite input=y_COV2 output=C:\DP_LF\vypocet\y_stats_COV2.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV2 output=C:\DP_LF\vypocet\stats_COV2.txt separator=space null_value=* nsteps=255
r.recode --overwrite input=y output=y_COV3 rules=C:\DP_LF\vypocet\recl_COV3.txt
r.stats -a -n --overwrite input=y_COV3 output=C:\DP_LF\vypocet\y_stats_COV3.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV3 output=C:\DP_LF\vypocet\stats_COV3.txt separator=space null_value=* nsteps=255
r.colors -e map=y color=gyr
r.recode --overwrite input=y output=ba rules=C:\DP_LF\vypocet\recl_y.txt title=kategorie
r.out.png -t --overwrite input=y output=C:\DP_LF\vypocet\y.png compression=7
r.recode --overwrite input=y output=y_COV1 rules=C:\DP_LF\vypocet\recl_COV1.txt title=validation
r.stats -a -n --overwrite input=y_COV1 output=C:\DP_LF\vypocet\y_stats_COV1.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV1 output=C:\DP_LF\vypocet\stats_COV1.txt separator=space null_value=* nsteps=255
r.recode --overwrite input=y output=y_COV2 rules=C:\DP_LF\vypocet\recl_COV2.txt
r.stats -a -n --overwrite input=y_COV2 output=C:\DP_LF\vypocet\y_stats_COV2.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV2 output=C:\DP_LF\vypocet\stats_COV2.txt separator=space null_value=* nsteps=255
r.recode --overwrite input=y output=y_COV3 rules=C:\DP_LF\vypocet\recl_COV3.txt
r.stats -a -n --overwrite input=y_COV3 output=C:\DP_LF\vypocet\y_stats_COV3.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV3 output=C:\DP_LF\vypocet\stats_COV3.txt separator=space null_value=* nsteps=255
r.colors -e map=y color=gyr
r.recode --overwrite input=y output=ba rules=C:\DP_LF\vypocet\recl_y.txt title=kategorie
r.out.png -t --overwrite input=y output=C:\DP_LF\vypocet\y.png compression=7
r.recode --overwrite input=y output=y_COV1 rules=C:\DP_LF\vypocet\recl_COV1.txt title=validation
r.stats -a -n --overwrite input=y_COV1 output=C:\DP_LF\vypocet\y_stats_COV1.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV1 output=C:\DP_LF\vypocet\stats_COV1.txt separator=space null_value=* nsteps=255
r.recode --overwrite input=y output=y_COV2 rules=C:\DP_LF\vypocet\recl_COV2.txt
r.stats -a -n --overwrite input=y_COV2 output=C:\DP_LF\vypocet\y_stats_COV2.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV2 output=C:\DP_LF\vypocet\stats_COV2.txt separator=space null_value=* nsteps=255
r.recode --overwrite input=y output=y_COV3 rules=C:\DP_LF\vypocet\recl_COV3.txt
r.stats -a -n --overwrite input=y_COV3 output=C:\DP_LF\vypocet\y_stats_COV3.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV3 output=C:\DP_LF\vypocet\stats_COV3.txt separator=space null_value=* nsteps=255
r.colors -e map=y color=gyr
r.recode --overwrite input=y output=ba rules=C:\DP_LF\vypocet\recl_y.txt title=kategorie
r.out.png -t --overwrite input=y output=C:\DP_LF\vypocet\y.png compression=7
r.recode --overwrite input=y output=y_COV1 rules=C:\DP_LF\vypocet\recl_COV1.txt title=validation
r.stats -a -n --overwrite input=y_COV1 output=C:\DP_LF\vypocet\y_stats_COV1.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV1 output=C:\DP_LF\vypocet\stats_COV1.txt separator=space null_value=* nsteps=255
r.recode --overwrite input=y output=y_COV2 rules=C:\DP_LF\vypocet\recl_COV2.txt
r.stats -a -n --overwrite input=y_COV2 output=C:\DP_LF\vypocet\y_stats_COV2.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV2 output=C:\DP_LF\vypocet\stats_COV2.txt separator=space null_value=* nsteps=255
r.recode --overwrite input=y output=y_COV3 rules=C:\DP_LF\vypocet\recl_COV3.txt
r.stats -a -n --overwrite input=y_COV3 output=C:\DP_LF\vypocet\y_stats_COV3.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV3 output=C:\DP_LF\vypocet\stats_COV3.txt separator=space null_value=* nsteps=255
r.colors -e map=y color=gyr
r.recode --overwrite input=y output=ba rules=C:\DP_LF\vypocet\recl_y.txt title=kategorie
r.out.png -t --overwrite input=y output=C:\DP_LF\vypocet\y.png compression=7
r.recode --overwrite input=y output=y_COV1 rules=C:\DP_LF\vypocet\recl_COV1.txt title=validation
r.stats -a -n --overwrite input=y_COV1 output=C:\DP_LF\vypocet\y_stats_COV1.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV1 output=C:\DP_LF\vypocet\stats_COV1.txt separator=space null_value=* nsteps=255
r.recode --overwrite input=y output=y_COV2 rules=C:\DP_LF\vypocet\recl_COV2.txt
r.stats -a -n --overwrite input=y_COV2 output=C:\DP_LF\vypocet\y_stats_COV2.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV2 output=C:\DP_LF\vypocet\stats_COV2.txt separator=space null_value=* nsteps=255
r.recode --overwrite input=y output=y_COV3 rules=C:\DP_LF\vypocet\recl_COV3.txt
r.stats -a -n --overwrite input=y_COV3 output=C:\DP_LF\vypocet\y_stats_COV3.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV3 output=C:\DP_LF\vypocet\stats_COV3.txt separator=space null_value=* nsteps=255
r.colors -e map=y color=gyr
r.recode --overwrite input=y output=ba rules=C:\DP_LF\vypocet\recl_y.txt title=kategorie
r.out.png -t --overwrite input=y output=C:\DP_LF\vypocet\y.png compression=7
r.recode --overwrite input=y output=y_COV1 rules=C:\DP_LF\vypocet\recl_COV1.txt title=validation
r.stats -a -n --overwrite input=y_COV1 output=C:\DP_LF\vypocet\y_stats_COV1.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV1 output=C:\DP_LF\vypocet\stats_COV1.txt separator=space null_value=* nsteps=255
r.recode --overwrite input=y output=y_COV2 rules=C:\DP_LF\vypocet\recl_COV2.txt
r.stats -a -n --overwrite input=y_COV2 output=C:\DP_LF\vypocet\y_stats_COV2.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV2 output=C:\DP_LF\vypocet\stats_COV2.txt separator=space null_value=* nsteps=255
r.recode --overwrite input=y output=y_COV3 rules=C:\DP_LF\vypocet\recl_COV3.txt
r.stats -a -n --overwrite input=y_COV3 output=C:\DP_LF\vypocet\y_stats_COV3.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV3 output=C:\DP_LF\vypocet\stats_COV3.txt separator=space null_value=* nsteps=255
r.colors -e map=y color=gyr
r.recode --overwrite input=y output=ba rules=C:\DP_LF\vypocet\recl_y.txt title=kategorie
r.out.png -t --overwrite input=y output=C:\DP_LF\vypocet\y.png compression=7
r.recode --overwrite input=y output=y_COV1 rules=C:\DP_LF\vypocet\recl_COV1.txt title=validation
r.stats -a -n --overwrite input=y_COV1 output=C:\DP_LF\vypocet\y_stats_COV1.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV1 output=C:\DP_LF\vypocet\stats_COV1.txt separator=space null_value=* nsteps=255
r.recode --overwrite input=y output=y_COV2 rules=C:\DP_LF\vypocet\recl_COV2.txt
r.stats -a -n --overwrite input=y_COV2 output=C:\DP_LF\vypocet\y_stats_COV2.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV2 output=C:\DP_LF\vypocet\stats_COV2.txt separator=space null_value=* nsteps=255
r.recode --overwrite input=y output=y_COV3 rules=C:\DP_LF\vypocet\recl_COV3.txt
r.stats -a -n --overwrite input=y_COV3 output=C:\DP_LF\vypocet\y_stats_COV3.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV3 output=C:\DP_LF\vypocet\stats_COV3.txt separator=space null_value=* nsteps=255
r.colors -e map=y color=gyr
r.recode --overwrite input=y output=ba rules=C:\DP_LF\vypocet\recl_y.txt title=kategorie
r.out.png -t --overwrite input=y output=C:\DP_LF\vypocet\y.png compression=7
r.recode --overwrite input=y output=y_COV1 rules=C:\DP_LF\vypocet\recl_COV1.txt title=validation
r.stats -a -n --overwrite input=y_COV1 output=C:\DP_LF\vypocet\y_stats_COV1.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV1 output=C:\DP_LF\vypocet\stats_COV1.txt separator=space null_value=* nsteps=255
r.recode --overwrite input=y output=y_COV2 rules=C:\DP_LF\vypocet\recl_COV2.txt
r.stats -a -n --overwrite input=y_COV2 output=C:\DP_LF\vypocet\y_stats_COV2.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV2 output=C:\DP_LF\vypocet\stats_COV2.txt separator=space null_value=* nsteps=255
r.recode --overwrite input=y output=y_COV3 rules=C:\DP_LF\vypocet\recl_COV3.txt
r.stats -a -n --overwrite input=y_COV3 output=C:\DP_LF\vypocet\y_stats_COV3.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV3 output=C:\DP_LF\vypocet\stats_COV3.txt separator=space null_value=* nsteps=255
r.colors -e map=y color=gyr
r.recode --overwrite input=y output=ba rules=C:\DP_LF\vypocet\recl_y.txt title=kategorie
r.out.png -t --overwrite input=y output=C:\DP_LF\vypocet\y.png compression=7
r.recode --overwrite input=y output=y_COV1 rules=C:\DP_LF\vypocet\recl_COV1.txt title=validation
r.stats -a -n --overwrite input=y_COV1 output=C:\DP_LF\vypocet\y_stats_COV1.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV1 output=C:\DP_LF\vypocet\stats_COV1.txt separator=space null_value=* nsteps=255
r.recode --overwrite input=y output=y_COV2 rules=C:\DP_LF\vypocet\recl_COV2.txt
r.stats -a -n --overwrite input=y_COV2 output=C:\DP_LF\vypocet\y_stats_COV2.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV2 output=C:\DP_LF\vypocet\stats_COV2.txt separator=space null_value=* nsteps=255
r.recode --overwrite input=y output=y_COV3 rules=C:\DP_LF\vypocet\recl_COV3.txt
r.stats -a -n --overwrite input=y_COV3 output=C:\DP_LF\vypocet\y_stats_COV3.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV3 output=C:\DP_LF\vypocet\stats_COV3.txt separator=space null_value=* nsteps=255
r.colors -e map=y color=gyr
r.recode --overwrite input=y output=ba rules=C:\DP_LF\vypocet\recl_y.txt title=kategorie
r.out.png -t --overwrite input=y output=C:\DP_LF\vypocet\y.png compression=7
r.recode --overwrite input=y output=y_COV1 rules=C:\DP_LF\vypocet\recl_COV1.txt title=validation
r.stats -a -n --overwrite input=y_COV1 output=C:\DP_LF\vypocet\y_stats_COV1.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV1 output=C:\DP_LF\vypocet\stats_COV1.txt separator=space null_value=* nsteps=255
r.recode --overwrite input=y output=y_COV2 rules=C:\DP_LF\vypocet\recl_COV2.txt
r.stats -a -n --overwrite input=y_COV2 output=C:\DP_LF\vypocet\y_stats_COV2.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV2 output=C:\DP_LF\vypocet\stats_COV2.txt separator=space null_value=* nsteps=255
r.recode --overwrite input=y output=y_COV3 rules=C:\DP_LF\vypocet\recl_COV3.txt
r.stats -a -n --overwrite input=y_COV3 output=C:\DP_LF\vypocet\y_stats_COV3.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV3 output=C:\DP_LF\vypocet\stats_COV3.txt separator=space null_value=* nsteps=255
r.colors -e map=y color=gyr
r.recode --overwrite input=y output=ba rules=C:\DP_LF\vypocet\recl_y.txt title=kategorie
r.out.png -t --overwrite input=y output=C:\DP_LF\vypocet\y.png compression=7
r.recode --overwrite input=y output=y_COV1 rules=C:\DP_LF\vypocet\recl_COV1.txt title=validation
r.stats -a -n --overwrite input=y_COV1 output=C:\DP_LF\vypocet\y_stats_COV1.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV1 output=C:\DP_LF\vypocet\stats_COV1.txt separator=space null_value=* nsteps=255
r.recode --overwrite input=y output=y_COV2 rules=C:\DP_LF\vypocet\recl_COV2.txt
r.stats -a -n --overwrite input=y_COV2 output=C:\DP_LF\vypocet\y_stats_COV2.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV2 output=C:\DP_LF\vypocet\stats_COV2.txt separator=space null_value=* nsteps=255
r.recode --overwrite input=y output=y_COV3 rules=C:\DP_LF\vypocet\recl_COV3.txt
r.stats -a -n --overwrite input=y_COV3 output=C:\DP_LF\vypocet\y_stats_COV3.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV3 output=C:\DP_LF\vypocet\stats_COV3.txt separator=space null_value=* nsteps=255
r.colors -e map=y color=gyr
r.recode --overwrite input=y output=ba rules=C:\DP_LF\vypocet\recl_y.txt title=kategorie
r.out.png -t --overwrite input=y output=C:\DP_LF\vypocet\y.png compression=7
r.recode --overwrite input=y output=y_COV1 rules=C:\DP_LF\vypocet\recl_COV1.txt title=validation
r.stats -a -n --overwrite input=y_COV1 output=C:\DP_LF\vypocet\y_stats_COV1.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV1 output=C:\DP_LF\vypocet\stats_COV1.txt separator=space null_value=* nsteps=255
r.recode --overwrite input=y output=y_COV2 rules=C:\DP_LF\vypocet\recl_COV2.txt
r.stats -a -n --overwrite input=y_COV2 output=C:\DP_LF\vypocet\y_stats_COV2.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV2 output=C:\DP_LF\vypocet\stats_COV2.txt separator=space null_value=* nsteps=255
r.recode --overwrite input=y output=y_COV3 rules=C:\DP_LF\vypocet\recl_COV3.txt
r.stats -a -n --overwrite input=y_COV3 output=C:\DP_LF\vypocet\y_stats_COV3.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV3 output=C:\DP_LF\vypocet\stats_COV3.txt separator=space null_value=* nsteps=255
r.colors -e map=y color=gyr
r.recode --overwrite input=y output=ba rules=C:\DP_LF\vypocet\recl_y.txt title=kategorie
r.out.png -t --overwrite input=y output=C:\DP_LF\vypocet\y.png compression=7
r.recode --overwrite input=y output=y_COV1 rules=C:\DP_LF\vypocet\recl_COV1.txt title=validation
r.stats -a -n --overwrite input=y_COV1 output=C:\DP_LF\vypocet\y_stats_COV1.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV1 output=C:\DP_LF\vypocet\stats_COV1.txt separator=space null_value=* nsteps=255
r.recode --overwrite input=y output=y_COV2 rules=C:\DP_LF\vypocet\recl_COV2.txt
r.stats -a -n --overwrite input=y_COV2 output=C:\DP_LF\vypocet\y_stats_COV2.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV2 output=C:\DP_LF\vypocet\stats_COV2.txt separator=space null_value=* nsteps=255
r.recode --overwrite input=y output=y_COV3 rules=C:\DP_LF\vypocet\recl_COV3.txt
r.stats -a -n --overwrite input=y_COV3 output=C:\DP_LF\vypocet\y_stats_COV3.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV3 output=C:\DP_LF\vypocet\stats_COV3.txt separator=space null_value=* nsteps=255
r.colors -e map=y color=gyr
r.recode --overwrite input=y output=ba rules=C:\DP_LF\vypocet\recl_y.txt title=kategorie
r.out.png -t --overwrite input=y output=C:\DP_LF\vypocet\y.png compression=7
r.recode --overwrite input=y output=y_COV1 rules=C:\DP_LF\vypocet\recl_COV1.txt title=validation
r.stats -a -n --overwrite input=y_COV1 output=C:\DP_LF\vypocet\y_stats_COV1.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV1 output=C:\DP_LF\vypocet\stats_COV1.txt separator=space null_value=* nsteps=255
r.recode --overwrite input=y output=y_COV2 rules=C:\DP_LF\vypocet\recl_COV2.txt
r.stats -a -n --overwrite input=y_COV2 output=C:\DP_LF\vypocet\y_stats_COV2.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV2 output=C:\DP_LF\vypocet\stats_COV2.txt separator=space null_value=* nsteps=255
r.recode --overwrite input=y output=y_COV3 rules=C:\DP_LF\vypocet\recl_COV3.txt
r.stats -a -n --overwrite input=y_COV3 output=C:\DP_LF\vypocet\y_stats_COV3.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV3 output=C:\DP_LF\vypocet\stats_COV3.txt separator=space null_value=* nsteps=255
r.colors -e map=y color=gyr
r.recode --overwrite input=y output=ba rules=C:\DP_LF\vypocet\recl_y.txt title=kategorie
r.out.png -t --overwrite input=y output=C:\DP_LF\vypocet\y.png compression=7
r.recode --overwrite input=y output=y_COV1 rules=C:\DP_LF\vypocet\recl_COV1.txt title=validation
r.stats -a -n --overwrite input=y_COV1 output=C:\DP_LF\vypocet\y_stats_COV1.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV1 output=C:\DP_LF\vypocet\stats_COV1.txt separator=space null_value=* nsteps=255
r.recode --overwrite input=y output=y_COV2 rules=C:\DP_LF\vypocet\recl_COV2.txt
r.stats -a -n --overwrite input=y_COV2 output=C:\DP_LF\vypocet\y_stats_COV2.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV2 output=C:\DP_LF\vypocet\stats_COV2.txt separator=space null_value=* nsteps=255
r.recode --overwrite input=y output=y_COV3 rules=C:\DP_LF\vypocet\recl_COV3.txt
r.stats -a -n --overwrite input=y_COV3 output=C:\DP_LF\vypocet\y_stats_COV3.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV3 output=C:\DP_LF\vypocet\stats_COV3.txt separator=space null_value=* nsteps=255
r.colors -e map=y color=gyr
r.recode --overwrite input=y output=ba rules=C:\DP_LF\vypocet\recl_y.txt title=kategorie
r.out.png -t --overwrite input=y output=C:\DP_LF\vypocet\y.png compression=7
r.recode --overwrite input=y output=y_COV1 rules=C:\DP_LF\vypocet\recl_COV1.txt title=validation
r.stats -a -n --overwrite input=y_COV1 output=C:\DP_LF\vypocet\y_stats_COV1.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV1 output=C:\DP_LF\vypocet\stats_COV1.txt separator=space null_value=* nsteps=255
r.recode --overwrite input=y output=y_COV2 rules=C:\DP_LF\vypocet\recl_COV2.txt
r.stats -a -n --overwrite input=y_COV2 output=C:\DP_LF\vypocet\y_stats_COV2.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV2 output=C:\DP_LF\vypocet\stats_COV2.txt separator=space null_value=* nsteps=255
r.recode --overwrite input=y output=y_COV3 rules=C:\DP_LF\vypocet\recl_COV3.txt
r.stats -a -n --overwrite input=y_COV3 output=C:\DP_LF\vypocet\y_stats_COV3.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV3 output=C:\DP_LF\vypocet\stats_COV3.txt separator=space null_value=* nsteps=255
r.colors -e map=y color=gyr
r.recode --overwrite input=y output=ba rules=C:\DP_LF\vypocet\recl_y.txt title=kategorie
r.out.png -t --overwrite input=y output=C:\DP_LF\vypocet\y.png compression=7
r.recode --overwrite input=y output=y_COV1 rules=C:\DP_LF\vypocet\recl_COV1.txt title=validation
r.stats -a -n --overwrite input=y_COV1 output=C:\DP_LF\vypocet\y_stats_COV1.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV1 output=C:\DP_LF\vypocet\stats_COV1.txt separator=space null_value=* nsteps=255
r.recode --overwrite input=y output=y_COV2 rules=C:\DP_LF\vypocet\recl_COV2.txt
r.stats -a -n --overwrite input=y_COV2 output=C:\DP_LF\vypocet\y_stats_COV2.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV2 output=C:\DP_LF\vypocet\stats_COV2.txt separator=space null_value=* nsteps=255
r.recode --overwrite input=y output=y_COV3 rules=C:\DP_LF\vypocet\recl_COV3.txt
r.stats -a -n --overwrite input=y_COV3 output=C:\DP_LF\vypocet\y_stats_COV3.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV3 output=C:\DP_LF\vypocet\stats_COV3.txt separator=space null_value=* nsteps=255
r.colors -e map=y color=gyr
r.recode --overwrite input=y output=ba rules=C:\DP_LF\vypocet\recl_y.txt title=kategorie
r.out.png -t --overwrite input=y output=C:\DP_LF\vypocet\y.png compression=7
r.recode --overwrite input=y output=y_COV1 rules=C:\DP_LF\vypocet\recl_COV1.txt title=validation
r.stats -a -n --overwrite input=y_COV1 output=C:\DP_LF\vypocet\y_stats_COV1.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV1 output=C:\DP_LF\vypocet\stats_COV1.txt separator=space null_value=* nsteps=255
r.recode --overwrite input=y output=y_COV2 rules=C:\DP_LF\vypocet\recl_COV2.txt
r.stats -a -n --overwrite input=y_COV2 output=C:\DP_LF\vypocet\y_stats_COV2.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV2 output=C:\DP_LF\vypocet\stats_COV2.txt separator=space null_value=* nsteps=255
r.recode --overwrite input=y output=y_COV3 rules=C:\DP_LF\vypocet\recl_COV3.txt
r.stats -a -n --overwrite input=y_COV3 output=C:\DP_LF\vypocet\y_stats_COV3.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV3 output=C:\DP_LF\vypocet\stats_COV3.txt separator=space null_value=* nsteps=255
r.colors -e map=y color=gyr
r.recode --overwrite input=y output=ba rules=C:\DP_LF\vypocet\recl_y.txt title=kategorie
r.out.png -t --overwrite input=y output=C:\DP_LF\vypocet\y.png compression=7
r.recode --overwrite input=y output=y_COV1 rules=C:\DP_LF\vypocet\recl_COV1.txt title=validation
r.stats -a -n --overwrite input=y_COV1 output=C:\DP_LF\vypocet\y_stats_COV1.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV1 output=C:\DP_LF\vypocet\stats_COV1.txt separator=space null_value=* nsteps=255
r.recode --overwrite input=y output=y_COV2 rules=C:\DP_LF\vypocet\recl_COV2.txt
r.stats -a -n --overwrite input=y_COV2 output=C:\DP_LF\vypocet\y_stats_COV2.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV2 output=C:\DP_LF\vypocet\stats_COV2.txt separator=space null_value=* nsteps=255
r.recode --overwrite input=y output=y_COV3 rules=C:\DP_LF\vypocet\recl_COV3.txt
r.stats -a -n --overwrite input=y_COV3 output=C:\DP_LF\vypocet\y_stats_COV3.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV3 output=C:\DP_LF\vypocet\stats_COV3.txt separator=space null_value=* nsteps=255
r.colors -e map=y color=gyr
r.recode --overwrite input=y output=ba rules=C:\DP_LF\vypocet\recl_y.txt title=kategorie
r.out.png -t --overwrite input=y output=C:\DP_LF\vypocet\y.png compression=7
r.recode --overwrite input=y output=y_COV1 rules=C:\DP_LF\vypocet\recl_COV1.txt title=validation
r.stats -a -n --overwrite input=y_COV1 output=C:\DP_LF\vypocet\y_stats_COV1.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV1 output=C:\DP_LF\vypocet\stats_COV1.txt separator=space null_value=* nsteps=255
r.recode --overwrite input=y output=y_COV2 rules=C:\DP_LF\vypocet\recl_COV2.txt
r.stats -a -n --overwrite input=y_COV2 output=C:\DP_LF\vypocet\y_stats_COV2.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV2 output=C:\DP_LF\vypocet\stats_COV2.txt separator=space null_value=* nsteps=255
r.recode --overwrite input=y output=y_COV3 rules=C:\DP_LF\vypocet\recl_COV3.txt
r.stats -a -n --overwrite input=y_COV3 output=C:\DP_LF\vypocet\y_stats_COV3.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV3 output=C:\DP_LF\vypocet\stats_COV3.txt separator=space null_value=* nsteps=255
r.colors -e map=y color=gyr
r.recode --overwrite input=y output=ba rules=C:\DP_LF\vypocet\recl_y.txt title=kategorie
r.out.png -t --overwrite input=y output=C:\DP_LF\vypocet\y.png compression=7
r.recode --overwrite input=y output=y_COV1 rules=C:\DP_LF\vypocet\recl_COV1.txt title=validation
r.stats -a -n --overwrite input=y_COV1 output=C:\DP_LF\vypocet\y_stats_COV1.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV1 output=C:\DP_LF\vypocet\stats_COV1.txt separator=space null_value=* nsteps=255
r.recode --overwrite input=y output=y_COV2 rules=C:\DP_LF\vypocet\recl_COV2.txt
r.stats -a -n --overwrite input=y_COV2 output=C:\DP_LF\vypocet\y_stats_COV2.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV2 output=C:\DP_LF\vypocet\stats_COV2.txt separator=space null_value=* nsteps=255
r.recode --overwrite input=y output=y_COV3 rules=C:\DP_LF\vypocet\recl_COV3.txt
r.stats -a -n --overwrite input=y_COV3 output=C:\DP_LF\vypocet\y_stats_COV3.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV3 output=C:\DP_LF\vypocet\stats_COV3.txt separator=space null_value=* nsteps=255
r.reclass --overwrite input=geology output=geology_recl2 rules=C:\DP_LF\vypocet\recl2\recl2_G.txt
r.reclass --overwrite input=dmr_recl1 output=dmr_recl2 rules=C:\DP_LF\vypocet\recl2\recl2_DMR.txt
r.reclass --overwrite input=slope_recl1 output=slope_recl2 rules=C:\DP_LF\vypocet\recl2\recl2_S.txt
r.reclass --overwrite input=aspect_recl1 output=aspect_recl2 rules=C:\DP_LF\vypocet\recl2\recl2_E.txt
r.reclass --overwrite input=landuse_recl1 output=landuse_recl2 rules=C:\DP_LF\vypocet\recl2\recl2_VK.txt
r.reclass --overwrite input=flowlength_recl1 output=flowlength_recl2 rules=C:\DP_LF\vypocet\recl2\recl2_DS.txt
r.reclass --overwrite input=accumulation_recl1 output=accumulation_recl2 rules=C:\DP_LF\vypocet\recl2\recl2_M.txt
r.reclass --overwrite input=curv_m_recl1 output=curv_m_recl2 rules=C:\DP_LF\vypocet\recl2\recl2_K.txt
r.mapcalc --overwrite file=C:\DP_LF\vypocet\rovnica.txt
r.univar -g --overwrite map=y output=C:\DP_LF\vypocet\info_y.txt percentile=90 separator=pipe
r.univar map=y@PERMANENT
r.colors map=y file=C:\DP_LF\nastroj\files\display\f_vysledok.txt
r.recode --overwrite input=y output=ba rules=C:\DP_LF\vypocet\recl_y.txt title=kategorie
r.out.png -t --overwrite input=y output=C:\DP_LF\vypocet\y.png compression=7
r.recode --overwrite input=y output=y_COV1 rules=C:\DP_LF\vypocet\recl_COV1.txt title=validation
r.stats -a -n --overwrite input=y_COV1 output=C:\DP_LF\vypocet\y_stats_COV1.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV1 output=C:\DP_LF\vypocet\stats_COV1.txt separator=space null_value=* nsteps=255
r.recode --overwrite input=y output=y_COV2 rules=C:\DP_LF\vypocet\recl_COV2.txt
r.stats -a -n --overwrite input=y_COV2 output=C:\DP_LF\vypocet\y_stats_COV2.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV2 output=C:\DP_LF\vypocet\stats_COV2.txt separator=space null_value=* nsteps=255
r.recode --overwrite input=y output=y_COV3 rules=C:\DP_LF\vypocet\recl_COV3.txt
r.stats -a -n --overwrite input=y_COV3 output=C:\DP_LF\vypocet\y_stats_COV3.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV3 output=C:\DP_LF\vypocet\stats_COV3.txt separator=space null_value=* nsteps=255
r.colors -e map=y color=gyr
r.recode --overwrite input=y output=ba rules=C:\DP_LF\vypocet\recl_y.txt title=kategorie
r.out.png -t --overwrite input=y output=C:\DP_LF\vypocet\y.png compression=7
r.recode --overwrite input=y output=y_COV1 rules=C:\DP_LF\vypocet\recl_COV1.txt title=validation
r.stats -a -n --overwrite input=y_COV1 output=C:\DP_LF\vypocet\y_stats_COV1.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV1 output=C:\DP_LF\vypocet\stats_COV1.txt separator=space null_value=* nsteps=255
r.recode --overwrite input=y output=y_COV2 rules=C:\DP_LF\vypocet\recl_COV2.txt
r.stats -a -n --overwrite input=y_COV2 output=C:\DP_LF\vypocet\y_stats_COV2.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV2 output=C:\DP_LF\vypocet\stats_COV2.txt separator=space null_value=* nsteps=255
r.recode --overwrite input=y output=y_COV3 rules=C:\DP_LF\vypocet\recl_COV3.txt
r.stats -a -n --overwrite input=y_COV3 output=C:\DP_LF\vypocet\y_stats_COV3.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV3 output=C:\DP_LF\vypocet\stats_COV3.txt separator=space null_value=* nsteps=255
r.colors map=ba file=C:\DP_LF\nastroj\files\display\f_vysledok.txt
r.colors -e map=y color=gyr
r.recode --overwrite input=y output=ba rules=C:\DP_LF\vypocet\recl_y.txt title=kategorie
r.out.png -t --overwrite input=y output=C:\DP_LF\vypocet\y.png compression=7
r.recode --overwrite input=y output=y_COV1 rules=C:\DP_LF\vypocet\recl_COV1.txt title=validation
r.stats -a -n --overwrite input=y_COV1 output=C:\DP_LF\vypocet\y_stats_COV1.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV1 output=C:\DP_LF\vypocet\stats_COV1.txt separator=space null_value=* nsteps=255
r.recode --overwrite input=y output=y_COV2 rules=C:\DP_LF\vypocet\recl_COV2.txt
r.stats -a -n --overwrite input=y_COV2 output=C:\DP_LF\vypocet\y_stats_COV2.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV2 output=C:\DP_LF\vypocet\stats_COV2.txt separator=space null_value=* nsteps=255
r.recode --overwrite input=y output=y_COV3 rules=C:\DP_LF\vypocet\recl_COV3.txt
r.stats -a -n --overwrite input=y_COV3 output=C:\DP_LF\vypocet\y_stats_COV3.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV3 output=C:\DP_LF\vypocet\stats_COV3.txt separator=space null_value=* nsteps=255
r.colors map=ba file=C:\DP_LF\nastroj\files\display\f_vysledok.txt
r.colors -e map=y color=gyr
r.recode --overwrite input=y output=ba rules=C:\DP_LF\vypocet\recl_y.txt title=kategorie
r.out.png -t --overwrite input=y output=C:\DP_LF\vypocet\y.png compression=7
r.recode --overwrite input=y output=y_COV1 rules=C:\DP_LF\vypocet\recl_COV1.txt title=validation
r.stats -a -n --overwrite input=y_COV1 output=C:\DP_LF\vypocet\y_stats_COV1.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV1 output=C:\DP_LF\vypocet\stats_COV1.txt separator=space null_value=* nsteps=255
r.recode --overwrite input=y output=y_COV2 rules=C:\DP_LF\vypocet\recl_COV2.txt
r.stats -a -n --overwrite input=y_COV2 output=C:\DP_LF\vypocet\y_stats_COV2.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV2 output=C:\DP_LF\vypocet\stats_COV2.txt separator=space null_value=* nsteps=255
r.recode --overwrite input=y output=y_COV3 rules=C:\DP_LF\vypocet\recl_COV3.txt
r.stats -a -n --overwrite input=y_COV3 output=C:\DP_LF\vypocet\y_stats_COV3.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV3 output=C:\DP_LF\vypocet\stats_COV3.txt separator=space null_value=* nsteps=255
r.colors map=ba rules=C:\DP_LF\nastroj\files\display\f_vysledok.txt
r.univar map=ba@PERMANENT
r.quantile -r --quiet input=y quantiles=-1000000000 percentiles=95 bins=1000000
r.quantile -r --quiet input=y quantiles=-1000000000 percentiles=97 bins=1000000
r.colors -e map=y color=gyr
r.recode --overwrite input=y output=ba rules=C:\DP_LF\vypocet\recl_y.txt title=kategorie
r.out.png -t --overwrite input=y output=C:\DP_LF\vypocet\y.png compression=7
r.recode --overwrite input=y output=y_COV1 rules=C:\DP_LF\vypocet\recl_COV1.txt title=validation
r.stats -a -n --overwrite input=y_COV1 output=C:\DP_LF\vypocet\y_stats_COV1.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV1 output=C:\DP_LF\vypocet\stats_COV1.txt separator=space null_value=* nsteps=255
r.recode --overwrite input=y output=y_COV2 rules=C:\DP_LF\vypocet\recl_COV2.txt
r.stats -a -n --overwrite input=y_COV2 output=C:\DP_LF\vypocet\y_stats_COV2.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV2 output=C:\DP_LF\vypocet\stats_COV2.txt separator=space null_value=* nsteps=255
r.recode --overwrite input=y output=y_COV3 rules=C:\DP_LF\vypocet\recl_COV3.txt
r.stats -a -n --overwrite input=y_COV3 output=C:\DP_LF\vypocet\y_stats_COV3.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV3 output=C:\DP_LF\vypocet\stats_COV3.txt separator=space null_value=* nsteps=255
r.report
r.report map=dmr@PERMANENT units=k
r.report map=dmr_recl1@PERMANENT units=k,p
r.category
r.category map=ba@PERMANENT rules=C:\DP_LF\nastroj\files\display\cat_vysledok.txt
r.univar map=ba@PERMANENT
r.category
r.category map=ba@PERMANENT rules=C:\DP_LF\nastroj\files\display\cat_vysledok.txt
r.category map=ba@PERMANENT separator=space rules=C:\DP_LF\nastroj\files\display\cat_vysledok.txt
r.colors
r.colors map=ba@PERMANENT rules=C:\DP_LF\nastroj\files\display\f_vysledok.txt
r.category
r.category map=ba@PERMANENT separator=: rules=C:\DP_LF\nastroj\files\display\cat_vysledok.txt
v.in.ogr input=C:\DP_LF\data layer=zu output=zu geometry=None --overwrite -o
r.quantile
g.region raster=trial_rst@PERMANENT
g.remove type=raster name=trial_rst@PERMANENT
g.remove -f type=raster name=trial_rst@PERMANENT
g.remove -f type=vector name=area@PERMANENT,trial@PERMANENT,val_trial@PERMANENT,val@PERMANENT
