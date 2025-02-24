--/*==========================================================================*/
--/* COPYRIGHT Brainyworks LTD. 2001,2008                                     */
--/* LICENSED MATERIAL - PROGRAM PROPERTY OF Brainyworks LTD.                 */
--/*==========================================================================*/
--/*                                                                          */
--/* SYSTEM   : e-MARKETBRAIN                                                 */
--/*                                                                          */
--/* FILE     : CREATE VIEW SCRIPT.                                           */
--/* TABLE    : TMB_Sâ                                                      */
--/*                                                                          */
--/* Mod   yy/mm/dd   Coder         Comment                                   */
--/*-----+----------+-------------+-------------------------------------------*/
--/* %00 | YY/MM/DD |             | First Eddition.                           */
--/*==========================================================================*/

CREATE OR REPLACE VIEW TMB_Sâ
    (âsÔ
    ,âs¼¿
    ,âs¼Ji
    ,ÆÔID
    ,âsKpJnNú
    ,âsKpI¹Nú
    ,XÔ
    ,X¼¿
    ,X¼Ji
    ,xXKpJnNú
    ,xXKpI¹Nú
    ,o^ú
    ,o^Ò
    )
 AS SELECT 
    TMB_âsA.âsÔ
    ,TMB_âsA.âs¼¿
    ,TMB_âsA.âs¼Ji
    ,TMB_âsA.ÆÔID
    ,TMB_âsA.KpJnNú
    ,TMB_âsA.KpI¹Nú
    ,TMB_xXA.XÔ
    ,TMB_xXA.X¼¿
    ,TMB_xXA.X¼Ji
    ,TMB_xXA.KpJnNú
    ,TMB_xXA.KpI¹Nú
    ,TMB_xXA.o^ú
    ,TMB_xXA.o^Ò
 FROM TMB_âsA,TMB_xXA
 WHERE TMB_âsA.âsÔ=TMB_xXA.âsÔ;

COMMENT ON COLUMN TMB_Sâ.âsÔ IS 'TMB_ÆÔ.ÆÔR[hðQÆB';
COMMENT ON COLUMN TMB_Sâ.âs¼¿ IS '';
COMMENT ON COLUMN TMB_Sâ.âs¼Ji IS '';
COMMENT ON COLUMN TMB_Sâ.ÆÔID IS 'TMB_âsÆÔ.ÆÔIDðQÆB';
COMMENT ON COLUMN TMB_Sâ.âsKpJnNú IS '';
COMMENT ON COLUMN TMB_Sâ.âsKpI¹Nú IS '';
COMMENT ON COLUMN TMB_Sâ.XÔ IS '';
COMMENT ON COLUMN TMB_Sâ.X¼¿ IS '';
COMMENT ON COLUMN TMB_Sâ.X¼Ji IS '';
COMMENT ON COLUMN TMB_Sâ.xXKpJnNú IS '';
COMMENT ON COLUMN TMB_Sâ.xXKpI¹Nú IS '';
COMMENT ON COLUMN TMB_Sâ.o^ú IS '';
COMMENT ON COLUMN TMB_Sâ.o^Ò IS '';
EXIT;
