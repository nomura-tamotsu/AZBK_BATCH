--/*==========================================================================*/
--/* COPYRIGHT Brainyworks LTD. 2001,2008                                     */
--/* LICENSED MATERIAL - PROGRAM PROPERTY OF Brainyworks LTD.                 */
--/*==========================================================================*/
--/*                                                                          */
--/* SYSTEM   : e-MARKETBRAIN                                                 */
--/*                                                                          */
--/* FILE     : CREATE VIEW SCRIPT.                                           */
--/* TABLE    : TF_ÂÊ¾×OÝaà                                           */
--/*                                                                          */
--/* Mod   yy/mm/dd   Coder         Comment                                   */
--/*-----+----------+-------------+-------------------------------------------*/
--/* %00 | YY/MM/DD |             | First Eddition.                           */
--/*==========================================================================*/

CREATE OR REPLACE VIEW TF_ÂÊ¾×OÝaà
    (XÔ
    ,CIFNO
    ,¢ÑÔ
    ,ÂléÆÔ
    ,ÈÚID
    ,ûÀÔ
    ,ûÀûÔ
    ,}Ô
    ,ÊÝID
    ,´ÊÝ»Ýc
    ,vA®X
    ,o^Nú
    ,ÊØæªID
    ,ÅæªID
    ,Åßæøú
    ,ÏCID
    ,aüú
    ,úú
    ,XL[Ô
    ,üàÀ¨ê
    ,Kp¦
    ,Dö
    ,³{àz
    ,~·Z[g
    ,~·Zàz
    ,À¨ê
    ,·Zz
    ,TZ¹v
    ,f[^îú
    )
 AS SELECT 
    TF_ÂÊ¾×OÝaàA.XÔ
    ,TF_ÂÊ¾×OÝaàA.CIFNO
    ,TF_ÂÊ¾×OÝaàA.¢ÑÔ
    ,TF_ÂÊ¾×OÝaàA.ÂléÆÔ
    ,TF_ÂÊ¾×OÝaàA.ÈÚID
    ,TF_ÂÊ¾×OÝaàA.ûÀÔ
    ,TF_ÂÊ¾×OÝaàA.ûÀûÔ
    ,TF_ÂÊ¾×OÝaàA.}Ô
    ,TF_ÂÊ¾×OÝaàA.ÊÝID
    ,TF_ÂÊ¾×OÝaàA.´ÊÝ»Ýc
    ,TF_ÂÊ¾×OÝaàA.vA®X
    ,TF_ÂÊ¾×OÝaàA.o^Nú
    ,TF_ÂÊ¾×OÝaàA.ÊØæªID
    ,TF_ÂÊ¾×OÝaàA.ÅæªID
    ,TF_ÂÊ¾×OÝaàA.Åßæøú
    ,TF_ÂÊ¾×OÝaàA.ÏCID
    ,TF_ÂÊ¾×OÝaàA.aüú
    ,TF_ÂÊ¾×OÝaàA.úú
    ,TF_ÂÊ¾×OÝaàA.XL[Ô
    ,TF_ÂÊ¾×OÝaàA.üàÀ¨ê
    ,TF_ÂÊ¾×OÝaàA.Kp¦
    ,TF_ÂÊ¾×OÝaàA.Dö
    ,TF_ÂÊ¾×OÝaàA.³{àz
    ,TF_ÂÊ¾×OÝaàA.~·Z[g
    ,TF_ÂÊ¾×OÝaàA.~·Zàz
    ,TF_ÂÊ¾×OÝaàA.À¨ê
    ,TF_ÂÊ¾×OÝaàA.·Zz
    ,TF_ÂÊ¾×OÝaàA.TZ¹v
    ,TF_ÂÊ¾×OÝaàA.f[^îú
 FROM TF_ÂÊ¾×OÝaàA
;
COMMENT ON COLUMN TF_ÂÊ¾×OÝaàA.XÔ IS 'TM_cÆX.XÔðQÆB';
COMMENT ON COLUMN TF_ÂÊ¾×OÝaàA.CIFNO IS '';
COMMENT ON COLUMN TF_ÂÊ¾×OÝaàA.¢ÑÔ IS 'LøViÅè·j';
COMMENT ON COLUMN TF_ÂÊ¾×OÝaàA.ÂléÆÔ IS '';
COMMENT ON COLUMN TF_ÂÊ¾×OÝaàA.ÈÚID IS 'TM_ÈÚ.ÈÚIDðQÆB';
COMMENT ON COLUMN TF_ÂÊ¾×OÝaàA.ûÀÔ IS '';
COMMENT ON COLUMN TF_ÂÊ¾×OÝaàA.ûÀûÔ IS '5Åè';
COMMENT ON COLUMN TF_ÂÊ¾×OÝaàA.}Ô IS '';
COMMENT ON COLUMN TF_ÂÊ¾×OÝaàA.ÊÝID IS 'TM_ÊÝ.ÊÝIDðQÆB';
COMMENT ON COLUMN TF_ÂÊ¾×OÝaàA.´ÊÝ»Ýc IS 'OÝPÊ ZZZZZZZZZZZZZZ9.00';
COMMENT ON COLUMN TF_ÂÊ¾×OÝaàA.vA®X IS 'TM_cÆX.XÔðQÆB';
COMMENT ON COLUMN TF_ÂÊ¾×OÝaàA.o^Nú IS '¼ïYYYYMMDD';
COMMENT ON COLUMN TF_ÂÊ¾×OÝaàA.ÊØæªID IS 'TM_ÊØæª.ÊØªIDðQÆB';
COMMENT ON COLUMN TF_ÂÊ¾×OÝaàA.ÅæªID IS 'TM_Åæª.ÅæªIDðQÆB';
COMMENT ON COLUMN TF_ÂÊ¾×OÝaàA.Åßæøú IS '¼ïYYYYMMDD';
COMMENT ON COLUMN TF_ÂÊ¾×OÝaàA.ÏCID IS 'TM_ÏCR[h.ÏCIDðQÆ';
COMMENT ON COLUMN TF_ÂÊ¾×OÝaàA.aüú IS '¼ïYYYYMMDD';
COMMENT ON COLUMN TF_ÂÊ¾×OÝaàA.úú IS '¼ïYYYYMMDD';
COMMENT ON COLUMN TF_ÂÊ¾×OÝaàA.XL[Ô IS '';
COMMENT ON COLUMN TF_ÂÊ¾×OÝaàA.üàÀ¨ê IS '9999.9999999';
COMMENT ON COLUMN TF_ÂÊ¾×OÝaàA.Kp¦ IS '9999.9999999';
COMMENT ON COLUMN TF_ÂÊ¾×OÝaàA.Dö IS '9999.9999999';
COMMENT ON COLUMN TF_ÂÊ¾×OÝaàA.³{àz IS 'ZZZZZZZZZZZZZZ9.00';
COMMENT ON COLUMN TF_ÂÊ¾×OÝaàA.~·Z[g IS '9999.9999999';
COMMENT ON COLUMN TF_ÂÊ¾×OÝaàA.~·Zàz IS '³{àz~~·Z[g';
COMMENT ON COLUMN TF_ÂÊ¾×OÝaàA.À¨ê IS '9999.9999999';
COMMENT ON COLUMN TF_ÂÊ¾×OÝaàA.·Zz IS '~PÊ ZZZZZZZZZZZZZZ9.00';
COMMENT ON COLUMN TF_ÂÊ¾×OÝaàA.TZ¹v IS '-ZZZZZZZZZZZZZZ9.00i~·Zàz[TZ¹vj';
COMMENT ON COLUMN TF_ÂÊ¾×OÝaàA.f[^îú IS '¼ïYYYYMMDD';
EXIT;
