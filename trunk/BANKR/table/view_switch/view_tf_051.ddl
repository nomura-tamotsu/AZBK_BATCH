--/*==========================================================================*/
--/* COPYRIGHT Information Services International-Dentsu, Ltd.                */
--/*==========================================================================*/
--/*                                                                          */
--/* SYSTEM   : BANKER R^NgZ^[                                    */
--/*                                                                          */
--/* FILE     : CREATE VIEW SCRIPT.                                           */
--/* TABLE    : TF_ÂÊ¾×OÝaà                                           */
--/*                                                                          */
--/* Mod   yy/mm/dd   Coder         Comment                                   */
--/*-----+----------+-------------+-------------------------------------------*/
--/* %00 | YY/MM/DD |             | First Eddition.                           */
--/* %01 | 15/01/26 | y NêY | 1.0Î                                 */
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
    ,O×æøæÔ
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
    ,TF_ÂÊ¾×OÝaàA.O×æøæÔ
 FROM TF_ÂÊ¾×OÝaàA
;
COMMENT ON COLUMN TF_ÂÊ¾×OÝaà.XÔ IS 'TM_cÆX.XÔðQÆB';
COMMENT ON COLUMN TF_ÂÊ¾×OÝaà.CIFNO IS 'Lø10iÅè·j';
COMMENT ON COLUMN TF_ÂÊ¾×OÝaà.¢ÑÔ IS 'Lø10iÅè·j';
COMMENT ON COLUMN TF_ÂÊ¾×OÝaà.ÂléÆÔ IS 'ÂléÆÔF"99999999999"Åè@y¢gpz';
COMMENT ON COLUMN TF_ÂÊ¾×OÝaà.ÈÚID IS '3Åèi0pfBOjAÆ±¯ÊÔi2j{¤iæªÔi1j';
COMMENT ON COLUMN TF_ÂÊ¾×OÝaà.ûÀÔ IS 'VÅè';
COMMENT ON COLUMN TF_ÂÊ¾×OÝaà.ûÀûÔ IS 'y¢gpz';
COMMENT ON COLUMN TF_ÂÊ¾×OÝaà.}Ô IS '';
COMMENT ON COLUMN TF_ÂÊ¾×OÝaà.ÊÝID IS 'TM_ÊÝ.ÊÝIDðQÆB TM_ÊÝ.ÊÝªÌ=TMB_ÊÝ.ÊÝIDÆÈé';
COMMENT ON COLUMN TF_ÂÊ¾×OÝaà.´ÊÝ»Ýc IS 'OÝPÊ ZZZZZZZZZZZZZZ9.00';
COMMENT ON COLUMN TF_ÂÊ¾×OÝaà.vA®X IS 'TM_cÆX.XÔðQÆB';
COMMENT ON COLUMN TF_ÂÊ¾×OÝaà.o^Nú IS '¼ïYYYYMMDD';
COMMENT ON COLUMN TF_ÂÊ¾×OÝaà.ÊØæªID IS 'TM_ÊØæª.ÊØªIDðQÆB';
COMMENT ON COLUMN TF_ÂÊ¾×OÝaà.ÅæªID IS 'y¢gpz';
COMMENT ON COLUMN TF_ÂÊ¾×OÝaà.Åßæøú IS '¼ïYYYYMMDD';
COMMENT ON COLUMN TF_ÂÊ¾×OÝaà.ÏCID IS 'TM_ÏCR[h.ÏCIDðQÆ';
COMMENT ON COLUMN TF_ÂÊ¾×OÝaà.aüú IS '¼ïYYYYMMDD';
COMMENT ON COLUMN TF_ÂÊ¾×OÝaà.úú IS '¼ïYYYYMMDD';
COMMENT ON COLUMN TF_ÂÊ¾×OÝaà.XL[Ô IS 'TF_¤i.¤iIDðQÆB6Åèi0pfBOj';
COMMENT ON COLUMN TF_ÂÊ¾×OÝaà.üàÀ¨ê IS '9999.9999999';
COMMENT ON COLUMN TF_ÂÊ¾×OÝaà.Kp¦ IS '9999.9999999';
COMMENT ON COLUMN TF_ÂÊ¾×OÝaà.Dö IS '9999.9999999';
COMMENT ON COLUMN TF_ÂÊ¾×OÝaà.³{àz IS 'ZZZZZZZZZZZZZZ9.00';
COMMENT ON COLUMN TF_ÂÊ¾×OÝaà.~·Z[g IS '9999.9999999';
COMMENT ON COLUMN TF_ÂÊ¾×OÝaà.~·Zàz IS '³{àz~~·Z[g';
COMMENT ON COLUMN TF_ÂÊ¾×OÝaà.À¨ê IS '9999.9999999';
COMMENT ON COLUMN TF_ÂÊ¾×OÝaà.·Zz IS '~PÊ ZZZZZZZZZZZZZZ9.00';
COMMENT ON COLUMN TF_ÂÊ¾×OÝaà.TZ¹v IS '-ZZZZZZZZZZZZZZ9.00i~·Zàz[TZ¹vj';
COMMENT ON COLUMN TF_ÂÊ¾×OÝaà.f[^îú IS '¼ïYYYYMMDD';
COMMENT ON COLUMN TF_ÂÊ¾×OÝaà.O×æøæÔ IS '8Åèi0pfBOjB';
EXIT;
