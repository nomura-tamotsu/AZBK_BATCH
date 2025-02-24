--/*==========================================================================*/
--/* COPYRIGHT Brainyworks LTD. 2001,2008                                     */
--/* LICENSED MATERIAL - PROGRAM PROPERTY OF Brainyworks LTD.                 */
--/*==========================================================================*/
--/*                                                                          */
--/* SYSTEM   : e-MARKETBRAIN                                                 */
--/*                                                                          */
--/* FILE     : CREATE VIEW SCRIPT.                                           */
--/* TABLE    : TF_ΒΚΎΧMϋΐΎΧ                                       */
--/*                                                                          */
--/* Mod   yy/mm/dd   Coder         Comment                                   */
--/*-----+----------+-------------+-------------------------------------------*/
--/* %00 | YY/MM/DD |             | First Eddition.                           */
--/*==========================================================================*/

CREATE OR REPLACE VIEW TF_ΒΚΎΧMϋΐΎΧ
    (XΤ
    ,CIFNO
    ,’ΡΤ
    ,ΒlιΖΤ
    ,ϋΐΤ
    ,€iID
    ,ΑΏR[h
    ,ΑΏΌ
    ,Κ
    ,Y
    ,ΒΚ³{
    ,ζΎΰz
    ,πρΏz
    ,WΏz
    ,ζψϊ
    ,Είζψϊ
    ,ζ΅Xv
    ,aθζͺ
    ,f[^ξϊ
    )
 AS SELECT 
    TF_ΒΚΎΧMϋΐΎΧB.XΤ
    ,TF_ΒΚΎΧMϋΐΎΧB.CIFNO
    ,TF_ΒΚΎΧMϋΐΎΧB.’ΡΤ
    ,TF_ΒΚΎΧMϋΐΎΧB.ΒlιΖΤ
    ,TF_ΒΚΎΧMϋΐΎΧB.ϋΐΤ
    ,TF_ΒΚΎΧMϋΐΎΧB.€iID
    ,TF_ΒΚΎΧMϋΐΎΧB.ΑΏR[h
    ,TF_ΒΚΎΧMϋΐΎΧB.ΑΏΌ
    ,TF_ΒΚΎΧMϋΐΎΧB.Κ
    ,TF_ΒΚΎΧMϋΐΎΧB.Y
    ,TF_ΒΚΎΧMϋΐΎΧB.ΒΚ³{
    ,TF_ΒΚΎΧMϋΐΎΧB.ζΎΰz
    ,TF_ΒΚΎΧMϋΐΎΧB.πρΏz
    ,TF_ΒΚΎΧMϋΐΎΧB.WΏz
    ,TF_ΒΚΎΧMϋΐΎΧB.ζψϊ
    ,TF_ΒΚΎΧMϋΐΎΧB.Είζψϊ
    ,TF_ΒΚΎΧMϋΐΎΧB.ζ΅Xv
    ,TF_ΒΚΎΧMϋΐΎΧB.aθζͺ
    ,TF_ΒΚΎΧMϋΐΎΧB.f[^ξϊ
 FROM TF_ΒΚΎΧMϋΐΎΧB
;
COMMENT ON COLUMN TF_ΒΚΎΧMϋΐΎΧ.XΤ IS 'TM_cΖX.XΤπQΖB';
COMMENT ON COLUMN TF_ΒΚΎΧMϋΐΎΧ.CIFNO IS 'Lψ10iΕθ·j';
COMMENT ON COLUMN TF_ΒΚΎΧMϋΐΎΧ.’ΡΤ IS 'Lψ10iΕθ·j';
COMMENT ON COLUMN TF_ΒΚΎΧMϋΐΎΧ.ΒlιΖΤ IS 'ΒlιΖΤF"99999999999"Εθ@y’gpz';
COMMENT ON COLUMN TF_ΒΚΎΧMϋΐΎΧ.ϋΐΤ IS '7Εθi0pfBOj';
COMMENT ON COLUMN TF_ΒΚΎΧMϋΐΎΧ.€iID IS 'y’gpz';
COMMENT ON COLUMN TF_ΒΚΎΧMϋΐΎΧ.ΑΏR[h IS 't@hR[h8Εθ';
COMMENT ON COLUMN TF_ΒΚΎΧMϋΐΎΧ.ΑΏΌ IS 'ΑΏΌ';
COMMENT ON COLUMN TF_ΒΚΎΧMϋΐΎΧ.Κ IS 'ZZZZZZZZZZZZZZ9.00';
COMMENT ON COLUMN TF_ΒΚΎΧMϋΐΎΧ.Y IS 'ZZZZZZZZZZZZZZ9.00';
COMMENT ON COLUMN TF_ΒΚΎΧMϋΐΎΧ.ΒΚ³{ IS 'ZZZZZZZZZZZZZZ9.00';
COMMENT ON COLUMN TF_ΒΚΎΧMϋΐΎΧ.ζΎΰz IS 'ZZZZZZZZZZZZZZ9.00';
COMMENT ON COLUMN TF_ΒΚΎΧMϋΐΎΧ.πρΏz IS 'ZZZZZZZZZZZZZZ9.00';
COMMENT ON COLUMN TF_ΒΚΎΧMϋΐΎΧ.WΏz IS 'ZZZZZZZZZZZZZZ9.00';
COMMENT ON COLUMN TF_ΒΚΎΧMϋΐΎΧ.ζψϊ IS '';
COMMENT ON COLUMN TF_ΒΚΎΧMϋΐΎΧ.Είζψϊ IS '';
COMMENT ON COLUMN TF_ΒΚΎΧMϋΐΎΧ.ζ΅Xv IS 'ZZZZZZZZZZZZZZ9.00';
COMMENT ON COLUMN TF_ΒΚΎΧMϋΐΎΧ.aθζͺ IS '0FκΚaθ@1FΑθaθ@2FNISAaθ';
COMMENT ON COLUMN TF_ΒΚΎΧMϋΐΎΧ.f[^ξϊ IS '';
EXIT;
