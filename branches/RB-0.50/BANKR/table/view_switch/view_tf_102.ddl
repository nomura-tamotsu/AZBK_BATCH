--/*==========================================================================*/
--/* COPYRIGHT Brainyworks LTD. 2001,2008                                     */
--/* LICENSED MATERIAL - PROGRAM PROPERTY OF Brainyworks LTD.                 */
--/*==========================================================================*/
--/*                                                                          */
--/* SYSTEM   : e-MARKETBRAIN                                                 */
--/*                                                                          */
--/* FILE     : CREATE VIEW SCRIPT.                                           */
--/* TABLE    : TF_���i                                                       */
--/*                                                                          */
--/* Mod   yy/mm/dd   Coder         Comment                                   */
--/*-----+----------+-------------+-------------------------------------------*/
--/* %00 | YY/MM/DD |             | First Eddition.                           */
--/*==========================================================================*/

CREATE OR REPLACE VIEW TF_���i
    (���iID
    ,���i��
    ,���i����
    )
 AS SELECT 
    TF_���iB.���iID
    ,TF_���iB.���i��
    ,TF_���iB.���i����
 FROM TF_���iB
;
COMMENT ON COLUMN TF_���i.���iID IS '';
COMMENT ON COLUMN TF_���i.���i�� IS '';
COMMENT ON COLUMN TF_���i.���i���� IS '';
EXIT;
