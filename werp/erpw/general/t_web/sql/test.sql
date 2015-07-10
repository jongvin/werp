CREATE INDEX XIF14T_ACC_SLIP_BODY ON tia_acc_slip_body_t
(
       SLIP_ID                        ASC
);

CREATE INDEX XIF148T_ACC_SLIP_BODY ON tia_acc_slip_body_t
(
       BANK_CODE                      ASC
);

CREATE INDEX XIF370tia_acc_slip_body_t ON tia_acc_slip_body_t
(
       SUMMARY_CODE                   ASC,
       ACC_CODE                       ASC
);

CREATE INDEX XIF371tia_acc_slip_body_t ON tia_acc_slip_body_t
(
       VAT_CODE                       ASC
);

CREATE INDEX XIF373tia_acc_slip_body_t ON tia_acc_slip_body_t
(
       CUST_CODE                       ASC
);

CREATE INDEX XIF383tia_acc_slip_body_t ON tia_acc_slip_body_t
(
       RESET_SLIP_ID                  ASC,
       RESET_SLIP_IDSEQ               ASC
);

CREATE INDEX XIF4T_ACC_SLIP_BODY ON tia_acc_slip_body_t
(
       ACC_CODE                       ASC
);

CREATE INDEX XIF55T_ACC_SLIP_BODY ON tia_acc_slip_body_t
(
       POSS_DEPT_PROJ                      ASC
);

CREATE INDEX XIF618tia_acc_slip_body_t ON tia_acc_slip_body_t
(
       ACCNO                          ASC
);

CREATE INDEX XIF664tia_acc_slip_body_t ON tia_acc_slip_body_t
(
       CLASS_CODE                     ASC
);

CREATE INDEX XIF677tia_acc_slip_body_t ON tia_acc_slip_body_t
(
       COMP_CODE                      ASC
);

CREATE INDEX XIF692tia_acc_slip_body_t ON tia_acc_slip_body_t
(
       TAX_COMP_CODE                  ASC
);

CREATE INDEX XIE10tia_acc_slip_body_t ON tia_acc_slip_body_t
(
       MAKE_COMP_CODE                 ASC
);

CREATE INDEX XIE11tia_acc_slip_body_t ON tia_acc_slip_body_t
(
       MAKE_DEPT_CODE                 ASC
);

CREATE INDEX XIE12tia_acc_slip_body_t ON tia_acc_slip_body_t
(
       MAKE_DT                        ASC
);

CREATE INDEX XIE8tia_acc_slip_body_t ON tia_acc_slip_body_t
(
       CUST_NAME                      ASC
);

CREATE INDEX XIE9tia_acc_slip_body_t ON tia_acc_slip_body_t
(
       VAT_DT                         ASC
);


