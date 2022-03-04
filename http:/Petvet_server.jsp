<%@page import="org.json.simple.JSONObject"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="dbConnectionPV.DBConnectionPV"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.Vector"%>
<%
    DBConnectionPV conn = new DBConnectionPV();
    String key = request.getParameter("key").trim();
    System.out.println(key);

    //    ---------Customer_Registration-------
    if (key.equals("customer_register")) {
        String NAME = request.getParameter("c_name");
        String ADDRESS = request.getParameter("c_address");
        String PHONE = request.getParameter("c_phone");
        String EMAIL = request.getParameter("c_email");
        String PASSWORD = request.getParameter("c_pswd");
        String DOJ = request.getParameter("c_doj");

        String insertqry = "SELECT COUNT(*) AS COUNT FROM `customer_reg` WHERE email='" + EMAIL + "' OR phone='" + PHONE + "'";
//          String insertqry="SELECT *  FROM `server` WHERE email='aji@gmail.com'";
        System.out.println(insertqry);
        Iterator it = conn.getData(insertqry).iterator();
        if (it.hasNext()) {
            Vector v = (Vector) it.next();
            int max_vid = Integer.parseInt(v.get(0).toString());
            System.out.println(max_vid);

            if (max_vid == 0) {

                String qry = "INSERT INTO customer_reg(name, address, phone, email, dateofjoin ) VALUES ('" + NAME + "', '" + ADDRESS + "', '" + PHONE + "', '" + EMAIL + "', '" + DOJ + "')";
                String qry1 = "INSERT INTO login(reg_id,email,password,type,status) VALUES((select max(c_id)from customer_reg),'" + EMAIL + "','" + PASSWORD + "','CUSTOMER','1')";
                System.out.println(qry + "\n" + qry1);
                if (conn.putData(qry) > 0 && conn.putData(qry1) > 0) {

                    System.out.println("Registered");
                    out.println("Registered");
                } else {

                    System.out.println("Registertion Failed");
                    out.println("Registertion Failed");
                }

            } else {

                System.out.println("Already Exist");
                out.print("Already Exist");

            }
        } else {
            out.print("failed");
        }
    }

//    ---------center_register-------
    if (key.equals("center_register")) {

        String NAME = request.getParameter("d_name");
        String OWNER = request.getParameter("d_owner");
        String ADDRESS = request.getParameter("d_address");
        String PHONE = request.getParameter("d_phone");
        String EMAIL = request.getParameter("d_email");
        String PASSWORD = request.getParameter("d_pswd");
        String TYPE = request.getParameter("d_center");
        String DOJ = request.getParameter("d_doj");

        String insertqry = "SELECT COUNT(*) AS COUNT FROM `center_reg` WHERE email='" + EMAIL.trim() + "' OR phone='" + PHONE.trim() + "'";
//          String insertqry="SELECT *  FROM `server` WHERE email='aji@gmail.com'";
        System.out.println(insertqry);
        Iterator it = conn.getData(insertqry).iterator();
        if (it.hasNext()) {
            Vector v = (Vector) it.next();
            int max_vid = Integer.parseInt(v.get(0).toString());
            System.out.println(max_vid);

            if (max_vid == 0) {

                String qry = "INSERT INTO `center_reg`(name, owner_name, address, phone, email, dateofjoin, type ) VALUES ('" + NAME + "', '" + OWNER + "', '" + ADDRESS + "', '" + PHONE + "', '" + EMAIL + "', '" + DOJ + "', '" + TYPE + "')";
                String qry1 = "INSERT INTO login(reg_id,email,password,type) VALUES((select max(cr_id)from `center_reg`),'" + EMAIL + "','" + PASSWORD + "','" + TYPE + "')";

                System.out.println(qry + "\n" + qry1);
                if (conn.putData(qry) > 0 && conn.putData(qry1) > 0) {

                    System.out.println("Registered");
                    out.println("Registered");
                } else {

                    System.out.println("Registertion Failed");
                    out.println("Registertion Failed");
                }

            } else {

                System.out.println("Already Exist");
                out.print("Already Exist");

            }
        } else {
            out.print("failed");
        }
    }

    //    ---------dogwalker_register-------
    if (key.equals("dogwalker_register")) {
        String NAME = request.getParameter("c_name");
        String ADDRESS = request.getParameter("c_address");
        String PHONE = request.getParameter("c_phone");
        String EMAIL = request.getParameter("c_email");
        String PASSWORD = request.getParameter("c_pswd");
        String DOJ = request.getParameter("c_doj");

        String insertqry = "SELECT COUNT(*) AS COUNT FROM `dogwalker_reg` WHERE email='" + EMAIL + "' OR phone='" + PHONE + "'";
//          String insertqry="SELECT *  FROM `server` WHERE email='aji@gmail.com'";
        System.out.println(insertqry);
        Iterator it = conn.getData(insertqry).iterator();
        if (it.hasNext()) {
            Vector v = (Vector) it.next();
            int max_vid = Integer.parseInt(v.get(0).toString());
            System.out.println(max_vid);

            if (max_vid == 0) {

                String qry = "INSERT INTO dogwalker_reg(name, address, phone, email, dateofjoin ) VALUES ('" + NAME + "', '" + ADDRESS + "', '" + PHONE + "', '" + EMAIL + "', '" + DOJ + "')";
                String qry1 = "INSERT INTO login(reg_id,email,password,type,status) VALUES((select max(dw_id)from dogwalker_reg),'" + EMAIL + "','" + PASSWORD + "','DOGWALKER','1')";
                System.out.println(qry + "\n" + qry1);
                if (conn.putData(qry) > 0 && conn.putData(qry1) > 0) {

                    System.out.println("Registered");
                    out.println("Registered");
                } else {

                    System.out.println("Registertion Failed");
                    out.println("Registertion Failed");
                }

            } else {

                System.out.println("Already Exist");
                out.print("Already Exist");

            }
        } else {
            out.print("failed");
        }
    }

    //    ---------Login-------
    if (key.trim().equals("login")) {

        String USERNAME = request.getParameter("U_name");
        String PASSWORD = request.getParameter("P_swd");

        String loginQry = "SELECT * FROM login WHERE email='" + USERNAME + "' AND password='" + PASSWORD + "' AND status='1'";
        System.out.println(loginQry);
        Iterator i = conn.getData(loginQry).iterator();

        if (i.hasNext()) {

            Vector v = (Vector) i.next();

            out.println(v.get(1) + "#" + v.get(4));

        } else {
            out.println("failed");

        }

    }

//    ---------------------viewCenter--------------------- 
    if (key.equals("viewCenter")) {
        String FID = request.getParameter("s_lid").trim();
        String qry = "SELECT * FROM `center_reg` cr, `login` l WHERE l.`reg_id` = cr.`cr_id` AND l.`status` = '0'";
        System.out.println("qry=" + qry);
        JSONArray array = new JSONArray();
        Iterator it = conn.getData(qry).iterator();
        if (it.hasNext()) {
            while (it.hasNext()) {
                Vector v = (Vector) it.next();
                JSONObject obj = new JSONObject();
                obj.put("cr_id", v.get(0).toString().trim());
                obj.put("s_name", v.get(1).toString().trim());
                obj.put("s_owner", v.get(2).toString().trim());
                obj.put("s_address", v.get(3).toString().trim());
                obj.put("s_phone", v.get(4).toString().trim());
                obj.put("s_email", v.get(5).toString().trim());
                obj.put("s_doj", v.get(6).toString().trim());
                obj.put("s_status", v.get(7).toString().trim());
                obj.put("s_type", v.get(8).toString().trim());
                array.add(obj);
            }
            out.println(array);
        } else {
            System.out.println("else id");
            out.print("failed");
        }
    }

    //    ---------deleteRequest-------
    if (key.equals("deleteRequest")) {
        String UID = request.getParameter("u_id");
        String RQSTID = request.getParameter("rqst_id");

        String str = "UPDATE `login` SET `status`='2' WHERE `reg_id`='" + RQSTID + "'";
        String str1 = "UPDATE `center_reg` SET `status`='REJECTED' WHERE `cr_id`='" + RQSTID + "'";
        if (conn.putData(str) > 0 && conn.putData(str1) > 0) {
            out.print("success");
        } else {
            out.print("failed");
        }

    }

    //    ---------approveRequest-------
    if (key.equals("approveRequest")) {
        String UID = request.getParameter("u_id");
        String RQSTID = request.getParameter("rqst_id");

        String str = "UPDATE `login` SET `status`='1' WHERE `reg_id`='" + RQSTID + "'";
        String str1 = "UPDATE `center_reg` SET `status`='APPROVED' WHERE `cr_id`='" + RQSTID + "'";
        if (conn.putData(str) > 0 && conn.putData(str1) > 0) {
            out.print("success");
        } else {
            out.print("failed");
        }

    }

//    ---------------------viewCenters--------------------- 
    if (key.equals("viewPetshop")) {
        String SID = request.getParameter("s_lid").trim();
        String qry = "SELECT * FROM `center_reg` WHERE `status` = 'APPROVED' AND `type`='PetShops'";
        System.out.println("qry=" + qry);
        JSONArray array = new JSONArray();
        Iterator it = conn.getData(qry).iterator();
        if (it.hasNext()) {
            while (it.hasNext()) {
                Vector v = (Vector) it.next();
                JSONObject obj = new JSONObject();
                obj.put("cr_id", v.get(0).toString().trim());
                obj.put("s_name", v.get(1).toString().trim());
                obj.put("s_owner", v.get(2).toString().trim());
                obj.put("s_address", v.get(3).toString().trim());
                obj.put("s_phone", v.get(4).toString().trim());
                obj.put("s_email", v.get(5).toString().trim());
                obj.put("s_doj", v.get(6).toString().trim());
                obj.put("s_status", v.get(7).toString().trim());
                obj.put("s_type", v.get(8).toString().trim());
                array.add(obj);
            }
            out.println(array);
        } else {
            System.out.println("else id");
            out.print("failed");
        }
    }

//    ---------------------viewVeterinary--------------------- 
    if (key.equals("viewVeterinary")) {
        String SID = request.getParameter("u_lid").trim();
        String qry = "SELECT * FROM `center_reg` WHERE `status` = 'APPROVED' AND `type`='Veterinary'";
        System.out.println("qry=" + qry);
        JSONArray array = new JSONArray();
        Iterator it = conn.getData(qry).iterator();
        if (it.hasNext()) {
            while (it.hasNext()) {
                Vector v = (Vector) it.next();
                JSONObject obj = new JSONObject();
                obj.put("cr_id", v.get(0).toString().trim());
                obj.put("s_name", v.get(1).toString().trim());
                obj.put("s_owner", v.get(2).toString().trim());
                obj.put("s_address", v.get(3).toString().trim());
                obj.put("s_phone", v.get(4).toString().trim());
                obj.put("s_email", v.get(5).toString().trim());
                obj.put("s_doj", v.get(6).toString().trim());
                obj.put("s_status", v.get(7).toString().trim());
                obj.put("s_type", v.get(8).toString().trim());
                array.add(obj);
            }
            out.println(array);
        } else {
            System.out.println("else id");
            out.print("failed");
        }
    }

//    ---------getComplaintPetshop-------
    if (key.equals("getComplaintPetshop")) {
        String UID = request.getParameter("p_lid").trim();
        String TYPE = request.getParameter("type").trim();
        String qry = "SELECT f.*, c.`name` FROM `customer_reg` c, `feedback` f WHERE f.`uid`=c.`c_id`";
        System.out.println("qry=" + qry);
        JSONArray array = new JSONArray();
        Iterator it = conn.getData(qry).iterator();
        if (it.hasNext()) {
            while (it.hasNext()) {
                Vector v = (Vector) it.next();
                JSONObject obj = new JSONObject();
                obj.put("fid", v.get(0).toString().trim());
                obj.put("uid", v.get(1).toString().trim());
                obj.put("subject", v.get(2).toString().trim());
                obj.put("description", v.get(3).toString().trim());
                obj.put("status", v.get(4).toString().trim());
                obj.put("type", v.get(5).toString().trim());
                obj.put("name", v.get(6).toString().trim());
                array.add(obj);
            }
            out.println(array);
        } else {
            System.out.println("else id");
            out.print("failed");
        }
    }

//    ---------getComplaintVeterinary-------
    if (key.equals("getComplaintVeterinary")) {
        String UID = request.getParameter("p_lid").trim();
        String TYPE = request.getParameter("type").trim();
        String qry = "SELECT f.*, c.`name` FROM `customer_reg` c, `feedback` f WHERE f.`uid`=c.`c_id`";
        System.out.println("qry=" + qry);
        JSONArray array = new JSONArray();
        Iterator it = conn.getData(qry).iterator();
        if (it.hasNext()) {
            while (it.hasNext()) {
                Vector v = (Vector) it.next();
                JSONObject obj = new JSONObject();
                obj.put("fid", v.get(0).toString().trim());
                obj.put("uid", v.get(1).toString().trim());
                obj.put("subject", v.get(2).toString().trim());
                obj.put("description", v.get(3).toString().trim());
                obj.put("type", v.get(4).toString().trim());
                obj.put("name", v.get(5).toString().trim());
                array.add(obj);
            }
            out.println(array);
        } else {
            System.out.println("else id");
            out.print("failed");
        }
    }

    //    ---------addPet-------
    if (key.equals("addPet")) {
        String UID = request.getParameter("uid").trim();
        String PROAGE = request.getParameter("p_age");
        String PRONAME = request.getParameter("p_name");
        String DESCRIPTION = request.getParameter("p_desc");
        String PRICE = request.getParameter("p_price");
        String BASE = request.getParameter("base_string");

        String str = "insert into `pet`(`p_id`,`p_name`, `p_age`, `p_description`,`p_rate`,`pet_image`) values('" + UID + "', '" + PRONAME + "', '" + PROAGE + "','" + DESCRIPTION + "','" + PRICE + "','" + BASE + "')";
        System.out.println(str);
        if (conn.putData(str) > 0) {
            out.print("success");
        } else {
            out.print("failed");
        }
    }

//    ---------addProduct-------
    if (key.equals("addProduct")) {
        String UID = request.getParameter("uid").trim();
        String PROQUANT = request.getParameter("p_quant");
        String PRONAME = request.getParameter("p_name");
        String DESCRIPTION = request.getParameter("p_desc");
        String PRICE = request.getParameter("p_price");
        String BASE = request.getParameter("base_string");
//        String insertqry = "SELECT * FROM `product` WHERE `p_name`='" + PRONAME + "'";
//        System.out.println(insertqry);
//        Iterator it = conn.getData(insertqry).iterator();
//        if (it.hasNext()) {
//
//            System.out.println("Already Exist");
//            out.print("Already Exist");
//
//        } else {

        String str = "insert into `product`(`p_id`,`p_name`, `p_quant`, `p_description`,`p_rate`,`property_image`) values('" + UID + "', '" + PRONAME + "', '" + PROQUANT + "','" + DESCRIPTION + "','" + PRICE + "','" + BASE + "')";
        System.out.println(str);
        if (conn.putData(str) > 0) {
            out.print("success");
        } else {
            out.print("failed");
        }
    }

//    ---------addDoctor-------
    if (key.equals("addDoctor")) {
        String UID = request.getParameter("uid").trim();
        String AGE = request.getParameter("p_age");
        String NAME = request.getParameter("p_name");
        String PHONE = request.getParameter("p_phone");
        String EMAIL = request.getParameter("p_email");
        String TIME = request.getParameter("p_time");
        String QUAL = request.getParameter("p_qual");
        String ADDR = request.getParameter("p_addr");
        String BASE = request.getParameter("base_string");
        String insertqry = "SELECT * FROM `doctor` WHERE `d_email`='" + EMAIL + "'";
        System.out.println(insertqry);
        Iterator it = conn.getData(insertqry).iterator();
        if (it.hasNext()) {

            System.out.println("Already Exist");
            out.print("Already Exist");

        } else {

            String str = "insert into `doctor`(`v_id`, `d_name`, `d_age`,`d_phone`, `d_address`, `d_qualification`, `d_email`, `d_timing`, `d_image`) values('" + UID + "', '" + NAME + "', '" + AGE + "', '" + PHONE + "','" + ADDR + "','" + QUAL + "','" + EMAIL + "', '" + TIME + "', '" + BASE + "')";

            System.out.println(str);
            if (conn.putData(str) > 0) {
                out.print("success");
            } else {
                out.print("failed");
            }
        }

    }

    //    ---------getDoctor-------
    if (key.equals("getDoctor")) {
        String SID = request.getParameter("p_lid").trim();
        String qry = "SELECT * FROM `doctor` WHERE `v_id`='" + SID + "' AND `status` = 'IN SERVICE'";
        System.out.println("qry=" + qry);
        JSONArray array = new JSONArray();
        Iterator it = conn.getData(qry).iterator();
        if (it.hasNext()) {
            while (it.hasNext()) {
                Vector v = (Vector) it.next();
                JSONObject obj = new JSONObject();
                obj.put("d_id", v.get(0).toString().trim());
                obj.put("d_vid", v.get(1).toString().trim());
                obj.put("d_name", v.get(2).toString().trim());
                obj.put("d_age", v.get(3).toString().trim());
                obj.put("d_phone", v.get(4).toString().trim());
                obj.put("d_address", v.get(5).toString().trim());
                obj.put("d_qualification", v.get(6).toString().trim());
                obj.put("d_email", v.get(7).toString().trim());
                obj.put("d_timing", v.get(8).toString().trim());
                obj.put("d_image", v.get(9).toString().trim());
                array.add(obj);
            }
            out.println(array);
        } else {
            System.out.println("else id");
            out.print("failed");
        }
    }

//    ---------getDoctorUser-------
    if (key.equals("getDoctorUser")) {
        String SID = request.getParameter("p_lid").trim();
        String qry = "SELECT * FROM `doctor` WHERE `v_id` = '" + SID + "' AND `status` = 'IN SERVICE'";
        System.out.println("qry=" + qry);
        JSONArray array = new JSONArray();
        Iterator it = conn.getData(qry).iterator();
        if (it.hasNext()) {
            while (it.hasNext()) {
                Vector v = (Vector) it.next();
                JSONObject obj = new JSONObject();
                obj.put("d_id", v.get(0).toString().trim());
                obj.put("d_vid", v.get(1).toString().trim());
                obj.put("d_name", v.get(2).toString().trim());
                obj.put("d_age", v.get(3).toString().trim());
                obj.put("d_phone", v.get(4).toString().trim());
                obj.put("d_address", v.get(5).toString().trim());
                obj.put("d_qualification", v.get(6).toString().trim());
                obj.put("d_email", v.get(7).toString().trim());
                obj.put("d_timing", v.get(8).toString().trim());
                obj.put("d_image", v.get(9).toString().trim());
                array.add(obj);
            }
            out.println(array);
        } else {
            System.out.println("else id");
            out.print("failed");
        }
    }

    //    ---------addAppointment-------
    if (key.equals("addAppointment")) {
        String UID = request.getParameter("u_id").trim();
        String DID = request.getParameter("d_id");
        String VRID = request.getParameter("vr_id");
        String DOJ = request.getParameter("p_doj");

        String str = "INSERT INTO `customer_request` (`c_id`, `vr_id`,  `d_id`, `rqst_time`, `status`) VALUES('" + UID + "', '" + VRID + "', '" + DID + "', '" + DOJ + "', 'REQUESTED')";
        System.out.println(str);
        if (conn.putData(str) > 0) {
            out.print("success");
        } else {
            out.print("failed");
        }
    }

//    ---------getVeterinary-------
    if (key.equals("getVeterinary")) {
        String SID = request.getParameter("p_lid").trim();
        String qry = "SELECT * FROM `center_reg` WHERE `type`='Veterinary'";
        System.out.println("qry=" + qry);
        JSONArray array = new JSONArray();
        Iterator it = conn.getData(qry).iterator();
        if (it.hasNext()) {
            while (it.hasNext()) {
                Vector v = (Vector) it.next();
                JSONObject obj = new JSONObject();
                obj.put("cr_id", v.get(0).toString().trim());
                obj.put("s_name", v.get(1).toString().trim());
                obj.put("s_owner", v.get(2).toString().trim());
                obj.put("s_address", v.get(3).toString().trim());
                obj.put("s_phone", v.get(4).toString().trim());
                obj.put("s_email", v.get(5).toString().trim());
                obj.put("s_doj", "");
                obj.put("s_status", v.get(7).toString().trim());
                obj.put("s_type", v.get(8).toString().trim());
                array.add(obj);
            }
            out.println(array);
        } else {
            System.out.println("else id");
            out.print("failed");
        }
    }

//    ---------getPetshop-------
    if (key.equals("getPetshop")) {
        String SID = request.getParameter("p_lid").trim();
        String qry = "SELECT * FROM `center_reg` WHERE `status` = 'APPROVED' AND `type`='PetShops'";
        System.out.println("qry=" + qry);
        JSONArray array = new JSONArray();
        Iterator it = conn.getData(qry).iterator();
        if (it.hasNext()) {
            while (it.hasNext()) {
                Vector v = (Vector) it.next();
                JSONObject obj = new JSONObject();
                obj.put("cr_id", v.get(0).toString().trim());
                obj.put("s_name", v.get(1).toString().trim());
                obj.put("s_owner", v.get(2).toString().trim());
                obj.put("s_address", v.get(3).toString().trim());
                obj.put("s_phone", v.get(4).toString().trim());
                obj.put("s_email", v.get(5).toString().trim());
                obj.put("s_doj", v.get(6).toString().trim());
                obj.put("s_status", v.get(7).toString().trim());
                obj.put("s_type", v.get(8).toString().trim());
                array.add(obj);
            }
            out.println(array);
        } else {
            System.out.println("else id");
            out.print("failed");
        }
    }

//    ---------getDogWalkers-------
    if (key.equals("getDogWalkers")) {
        String SID = request.getParameter("p_lid").trim();
        String TYPE = request.getParameter("t_ype").trim();
        String qry = "SELECT * FROM `dogwalker_reg` WHERE `status`='FREE'";
        System.out.println("qry=" + qry);
        JSONArray array = new JSONArray();
        Iterator it = conn.getData(qry).iterator();
        if (it.hasNext()) {
            while (it.hasNext()) {
                Vector v = (Vector) it.next();
                JSONObject obj = new JSONObject();
                obj.put("dw_id", v.get(0).toString().trim());
                obj.put("dw_name", v.get(1).toString().trim());
                obj.put("dw_address", v.get(2).toString().trim());
                obj.put("dw_phone", v.get(3).toString().trim());
                obj.put("dw_email", v.get(4).toString().trim());
                obj.put("dw_doj", v.get(5).toString().trim());
                obj.put("dw_status", v.get(6).toString().trim());
                obj.put("Xtype", TYPE + "");
                array.add(obj);
            }
            out.println(array);
        } else {
            System.out.println("else id");
            out.print("failed");
        }
    }

//    ---------getPetsUser-------
    if (key.equals("getPetsUser")) {
        String SID = request.getParameter("p_lid").trim();
        String qry = "SELECT p.* FROM `pet` p, `center_reg` cr WHERE p.`p_id`=cr.`cr_id` AND cr.`type`='PetShops' AND p.`p_id` = '" + SID + "' AND p.`status` = 'IN STOCK'";
        System.out.println("qry=" + qry);
        JSONArray array = new JSONArray();
        Iterator it = conn.getData(qry).iterator();
        if (it.hasNext()) {
            while (it.hasNext()) {
                Vector v = (Vector) it.next();
                JSONObject obj = new JSONObject();
                obj.put("pt_id", v.get(0).toString().trim());
                obj.put("p_id", v.get(1).toString().trim());
                obj.put("pt_name", v.get(2).toString().trim());
                obj.put("pt_age", v.get(3).toString().trim());
                obj.put("pt_description", v.get(4).toString().trim());
                obj.put("pt_rate", v.get(5).toString().trim());
                obj.put("pt_image", v.get(6).toString().trim());
                obj.put("Xtype", "PetShops PETS");
                array.add(obj);
            }
            out.println(array);
        } else {
            System.out.println("else id");
            out.print("failed");
        }
    }

    //    ---------getPetShopPets-------
    if (key.equals("getPetShopPets")) {
        String SID = request.getParameter("p_lid").trim();
        String TYPE = request.getParameter("t_ype").trim();
        String qry = "SELECT * FROM `pet` WHERE `p_id` = '" + SID + "' AND `status` = 'IN STOCK'";
        System.out.println("qry=" + qry);
        JSONArray array = new JSONArray();
        Iterator it = conn.getData(qry).iterator();
        if (it.hasNext()) {
            while (it.hasNext()) {
                Vector v = (Vector) it.next();
                JSONObject obj = new JSONObject();
                obj.put("pt_id", v.get(0).toString().trim());
                obj.put("p_id", v.get(1).toString().trim());
                obj.put("pt_name", v.get(2).toString().trim());
                obj.put("pt_age", v.get(3).toString().trim());
                obj.put("pt_description", v.get(4).toString().trim());
                obj.put("pt_rate", v.get(5).toString().trim());
                obj.put("pt_image", v.get(6).toString().trim());
                obj.put("Xstatus", v.get(7).toString().trim());
                obj.put("Xtype", TYPE + " PETS");
                array.add(obj);
            }
            out.println(array);
        } else {
            System.out.println("else id");
            out.print("failed");
        }

    }

//    ---------removePet-------
    if (key.equals("removePet")) {
        String UID = request.getParameter("u_id");
        String PID = request.getParameter("p_id");

        String str = "UPDATE `pet` SET `status` = 'SOLD' WHERE `p_id` = '" + UID + "' AND `pt_id` = '" + PID + "'";
        if (conn.putData(str) > 0) {
            out.print("success");
        } else {
            out.print("failed");
        }

    }

    //    ---------getPetShopProducts-------
    if (key.equals("getPetShopProducts")) {
        String SID = request.getParameter("p_lid").trim();
        String TYPE = request.getParameter("t_ype").trim();
        String qry = "SELECT * FROM `product` WHERE `p_id` = '" + SID + "' AND `status` = 'IN STOCK'";
        System.out.println("qry=" + qry);
        JSONArray array = new JSONArray();
        Iterator it = conn.getData(qry).iterator();
        if (it.hasNext()) {
            while (it.hasNext()) {
                Vector v = (Vector) it.next();
                JSONObject obj = new JSONObject();
                obj.put("pt_id", v.get(0).toString().trim());
                obj.put("p_id", v.get(1).toString().trim());
                obj.put("pt_name", v.get(2).toString().trim());
                obj.put("pt_age", v.get(3).toString().trim());
                obj.put("pt_description", v.get(4).toString().trim());
                obj.put("pt_rate", v.get(5).toString().trim());
                obj.put("pt_image", v.get(6).toString().trim());
                obj.put("Xstatus", v.get(7).toString().trim());
                obj.put("Xtype", TYPE + " PRODUCT");
                array.add(obj);
            }
            out.println(array);
        } else {
            System.out.println("else id");
            out.print("failed");
        }

    }

//    ---------removeProduct-------
    if (key.equals("removeProduct")) {
        String UID = request.getParameter("u_id");
        String PID = request.getParameter("p_id");

        String str = "UPDATE `product` SET `status` = 'SOLD' WHERE `p_id` = '" + UID + "' AND `pr_id` = '" + PID + "'";
        if (conn.putData(str) > 0) {
            out.print("success");
        } else {
            out.print("failed");
        }

    }

//    ---------removeDoctor-------
    if (key.equals("removeDoctor")) {
        String UID = request.getParameter("u_id");
        String PID = request.getParameter("p_id");

        String str = "UPDATE `doctor` SET `status` = 'OUT' WHERE `v_id` = '" + UID + "' AND `d_id` = '" + PID + "'";
        
        if (conn.putData(str) > 0) {
            out.print("success");
        } else {
            out.print("failed");
        }

    }

    //    ---------addRequestWorker-------
    if (key.equals("addRequestWorker")) {
        String UID = request.getParameter("u_id").trim();
        String DWID = request.getParameter("dw_id");
        String DOJ = request.getParameter("p_doj");

        String str = "INSERT INTO `dogwalker_request` (`dw_id`, `c_id`, `rqst_time`, `status`) VALUES('" + DWID + "', '" + UID + "', '" + DOJ + "', 'REQUESTED')";
        System.out.println(str);
        if (conn.putData(str) > 0) {
            out.print("success");
        } else {
            out.print("failed");
        }
    }

    //    ---------getAppointmentsDogWalker-------
    if (key.equals("getAppointmentsDogWalker")) {
        String SID = request.getParameter("p_lid").trim();
        String TYPE = request.getParameter("t_ype").trim();
//        String qry = "SELECT p.* , cr.`c_rqst_id`  FROM `customer_reg` c, `seller_reg` s, `property` p, `customer_request` cr  WHERE p.`p_id`=cr.`p_id` AND cr.`sr_id`=s.`sr_id` AND cr.`c_id`=c.`c_id` AND s.`sr_id`='" + SID + "' AND cr.`status`='REQUESTED'";
        String qry = "SELECT c.*, dr.`wr_rqst_id`, dr.`status`, dr.`rqst_time` FROM `dogwalker_request` dr, `customer_reg` c, `dogwalker_reg` dw WHERE dr.`dw_id` = dw.`dw_id` AND dr.`c_id` = c.`c_id` AND dr.`dw_id` = '" + SID + "' AND dr.`status` = 'REQUESTED'";
        System.out.println("qry=" + qry);
        JSONArray array = new JSONArray();
        Iterator it = conn.getData(qry).iterator();
        if (it.hasNext()) {
            while (it.hasNext()) {
                Vector v = (Vector) it.next();
                JSONObject obj = new JSONObject();
                obj.put("dw_id", v.get(0).toString().trim());
                obj.put("dw_name", v.get(1).toString().trim());
                obj.put("dw_address", v.get(2).toString().trim());
                obj.put("dw_phone", v.get(3).toString().trim());
                obj.put("dw_email", v.get(4).toString().trim());
                obj.put("dw_doj", v.get(9).toString().trim());
                obj.put("c_rqst_id", v.get(7).toString().trim());
                obj.put("Xstatus", v.get(8).toString().trim());
                obj.put("type", TYPE + "XY");
                array.add(obj);
            }
            out.println(array);
        } else {
            System.out.println("else id");
            out.print("failed");
        }
    }

    //    ---------addAppointmentPetshop-------
    if (key.equals("addAppointmentPetshop")) {
        String UID = request.getParameter("u_id").trim();
        String PETID = request.getParameter("p_id");
        String SHOPID = request.getParameter("s_id");
        String DOJ = request.getParameter("p_doj");

        String str = "INSERT INTO `petshop_request` (`ps_id`, `p_id`,  `c_id`, `rqst_time`, `status`) VALUES('" + SHOPID + "', '" + PETID + "', '" + UID + "', '" + DOJ + "', 'REQUESTED')";
        System.out.println(str);
        if (conn.putData(str) > 0) {
            out.print("success");
        } else {
            out.print("failed");
        }
    }

    //    ---------getRequestUser-------
    if (key.equals("getRequestUser")) {
        String SID = request.getParameter("p_lid").trim();
//        String qry = "SELECT p.* , cr.`c_rqst_id`  FROM `customer_reg` c, `seller_reg` s, `property` p, `customer_request` cr  WHERE p.`p_id`=cr.`p_id` AND cr.`sr_id`=s.`sr_id` AND cr.`c_id`=c.`c_id` AND s.`sr_id`='" + SID + "' AND cr.`status`='REQUESTED'";
        String qry = "SELECT p.* FROM `petshop_request` pr, `center_reg` cr, `pet` p, `customer_reg` c WHERE pr.`ps_id` = cr.`cr_id` AND cr.`type` = 'PetShops' AND pr.`p_id` = p.`pt_id` AND pr.`c_id` = c.`c_id` AND pr.`c_id` = '" + SID + "' AND pr.`status` = 'REQUESTED' AND p.`status` = 'IN STOCK'";
        System.out.println("qry=" + qry);
        JSONArray array = new JSONArray();
        Iterator it = conn.getData(qry).iterator();
        if (it.hasNext()) {
            while (it.hasNext()) {
                Vector v = (Vector) it.next();
                JSONObject obj = new JSONObject();
                obj.put("pt_id", v.get(0).toString().trim());
                obj.put("p_id", v.get(1).toString().trim());
                obj.put("pt_name", v.get(2).toString().trim());
                obj.put("pt_age", v.get(3).toString().trim());
                obj.put("pt_description", v.get(4).toString().trim());
                obj.put("pt_rate", v.get(5).toString().trim());
                obj.put("pt_image", v.get(6).toString().trim());
                obj.put("Xstatus", v.get(7).toString().trim());
                obj.put("Xtype", "PetShops PETS");
                array.add(obj);
            }
            out.println(array);
        } else {
            System.out.println("else id");
            out.print("failed");
        }
    }

    //    ---------getRequestApprovedUser-------
    if (key.equals("getRequestApprovedUser")) {
        String SID = request.getParameter("p_lid").trim();
//        String qry = "SELECT p.* , cr.`c_rqst_id`  FROM `customer_reg` c, `seller_reg` s, `property` p, `customer_request` cr  WHERE p.`p_id`=cr.`p_id` AND cr.`sr_id`=s.`sr_id` AND cr.`c_id`=c.`c_id` AND s.`sr_id`='" + SID + "' AND cr.`status`='REQUESTED'";
        String qry = "SELECT p.* FROM `petshop_request` pr, `center_reg` cr, `pet` p, `customer_reg` c WHERE pr.`ps_id` = cr.`cr_id` AND cr.`type` = 'PetShops' AND pr.`p_id` = p.`pt_id` AND pr.`c_id` = c.`c_id` AND pr.`c_id` = '" + SID + "' AND pr.`status` = 'APPROVED' AND p.`status` = 'IN STOCK'";
        System.out.println("qry=" + qry);
        JSONArray array = new JSONArray();
        Iterator it = conn.getData(qry).iterator();
        if (it.hasNext()) {
            while (it.hasNext()) {
                Vector v = (Vector) it.next();
                JSONObject obj = new JSONObject();
                obj.put("pt_id", v.get(0).toString().trim());
                obj.put("p_id", v.get(1).toString().trim());
                obj.put("pt_name", v.get(2).toString().trim());
                obj.put("pt_age", v.get(3).toString().trim());
                obj.put("pt_description", v.get(4).toString().trim());
                obj.put("pt_rate", v.get(5).toString().trim());
                obj.put("pt_image", v.get(6).toString().trim());
                obj.put("Xstatus", v.get(7).toString().trim());
                obj.put("Xtype", "PetShops PETS");
                array.add(obj);
            }
            out.println(array);
        } else {
            System.out.println("else id");
            out.print("failed");
        }
    }

//    ---------------------addFeedBack--------------------- 
    if (key.equals("addFeedBack")) {
        String sub = request.getParameter("subject");
        String desc = request.getParameter("description");
        String uid = request.getParameter("uid");
        String type = request.getParameter("type");

        String qry = "INSERT INTO `feedback` (`uid`,`subject`,`description`, `type` ) VALUES (" + uid + ",'" + sub + "','" + desc + "', '" + type + "') ";
        System.out.println(qry);
        if (conn.putData(qry) > 0) {

            out.print("successful");
        } else {
            out.print("failed");
        }
    }

    //    ---------getRequestPet-------
    if (key.equals("getRequestPet")) {
        String SID = request.getParameter("p_lid").trim();
//        String qry = "SELECT p.* , cr.`c_rqst_id`  FROM `customer_reg` c, `seller_reg` s, `property` p, `customer_request` cr  WHERE p.`p_id`=cr.`p_id` AND cr.`sr_id`=s.`sr_id` AND cr.`c_id`=c.`c_id` AND s.`sr_id`='" + SID + "' AND cr.`status`='REQUESTED'";
        String qry = "SELECT p.*, pr.`pr_rqst_id` FROM `petshop_request` pr, `center_reg` cr, `pet` p, `customer_reg` c WHERE pr.`ps_id` = cr.`cr_id` AND cr.`type` = 'PetShops' AND pr.`p_id` = p.`pt_id` AND pr.`c_id` = c.`c_id` AND pr.`ps_id` = '" + SID + "' AND pr.`status` = 'REQUESTED' AND p.`status` = 'IN STOCK'";
        System.out.println("qry=" + qry);
        JSONArray array = new JSONArray();
        Iterator it = conn.getData(qry).iterator();
        if (it.hasNext()) {
            while (it.hasNext()) {
                Vector v = (Vector) it.next();
                JSONObject obj = new JSONObject();
                obj.put("pt_id", v.get(0).toString().trim());
                obj.put("p_id", v.get(1).toString().trim());
                obj.put("pt_name", v.get(2).toString().trim());
                obj.put("pt_age", v.get(3).toString().trim());
                obj.put("pt_description", v.get(4).toString().trim());
                obj.put("pt_rate", v.get(5).toString().trim());
                obj.put("pt_image", v.get(6).toString().trim());
                obj.put("Xstatus", v.get(7).toString().trim());
                obj.put("pr_rqst", v.get(8).toString().trim());
                obj.put("Xtype", "PetShops PETS");
                array.add(obj);
            }
            out.println(array);
        } else {
            System.out.println("else id");
            out.print("failed");
        }
    }

//    ---------approvePetRequest-------
    if (key.equals("approvePetRequest")) {
        String UID = request.getParameter("u_id");
        String RQSTID = request.getParameter("rqst_id");

        String str = "UPDATE `petshop_request` SET `status` = 'APPROVED' WHERE `ps_id` = '" + UID + "' AND `pr_rqst_id` = '" + RQSTID + "'";
        if (conn.putData(str) > 0) {
            out.print("success");
        } else {
            out.print("failed");
        }

    }

//    ---------deletePetRqst-------
    if (key.equals("deletePetRqst")) {
        String UID = request.getParameter("u_id");
        String RQSTID = request.getParameter("rqst_id");

        String str = "UPDATE `petshop_request` SET `status` = 'REJECTED' WHERE `ps_id` = '" + UID + "' AND `pr_rqst_id` = '" + RQSTID + "'";
        if (conn.putData(str) > 0) {
            out.print("success");
        } else {
            out.print("failed");
        }

    }

    //    ---------getRequestApprovedPet-------
    if (key.equals("getRequestApprovedPet")) {
        String SID = request.getParameter("p_lid").trim();
//        String qry = "SELECT p.* , cr.`c_rqst_id`  FROM `customer_reg` c, `seller_reg` s, `property` p, `customer_request` cr  WHERE p.`p_id`=cr.`p_id` AND cr.`sr_id`=s.`sr_id` AND cr.`c_id`=c.`c_id` AND s.`sr_id`='" + SID + "' AND cr.`status`='REQUESTED'";
        String qry = "SELECT p.*, pr.`pr_rqst_id` FROM `petshop_request` pr, `center_reg` cr, `pet` p, `customer_reg` c WHERE pr.`ps_id` = cr.`cr_id` AND cr.`type` = 'PetShops' AND pr.`p_id` = p.`pt_id` AND pr.`c_id` = c.`c_id` AND pr.`ps_id` = '" + SID + "' AND pr.`status` = 'APPROVED' AND p.`status` = 'IN STOCK'";
        System.out.println("qry=" + qry);
        JSONArray array = new JSONArray();
        Iterator it = conn.getData(qry).iterator();
        if (it.hasNext()) {
            while (it.hasNext()) {
                Vector v = (Vector) it.next();
                JSONObject obj = new JSONObject();
                obj.put("pt_id", v.get(0).toString().trim());
                obj.put("p_id", v.get(1).toString().trim());
                obj.put("pt_name", v.get(2).toString().trim());
                obj.put("pt_age", v.get(3).toString().trim());
                obj.put("pt_description", v.get(4).toString().trim());
                obj.put("pt_rate", v.get(5).toString().trim());
                obj.put("pt_image", v.get(6).toString().trim());
                obj.put("Xstatus", v.get(7).toString().trim());
                obj.put("pr_rqst", v.get(8).toString().trim());
                obj.put("Xtype", "PetShops PETS");
                array.add(obj);
            }
            out.println(array);
        } else {
            System.out.println("else id");
            out.print("failed");
        }
    }

    //    ---------addAppointmentDoctor-------
    if (key.equals("addAppointmentDoctor")) {
        String UID = request.getParameter("u_id").trim();
        String DID = request.getParameter("d_id");
        String VRID = request.getParameter("vr_id");
        String DOJ = request.getParameter("p_doj");

        String str = "INSERT INTO `customer_request` (`c_id`, `vr_id`,  `d_id`, `rqst_time`, `status`) VALUES('" + UID + "', '" + VRID + "', '" + DID + "', '" + DOJ + "', 'REQUESTED')";
        System.out.println(str);
        if (conn.putData(str) > 0) {
            out.print("success");
        } else {
            out.print("failed");
        }
    }

    //    ---------getAppointmentsVeterinary-------
    if (key.equals("getAppointmentsVeterinary")) {
        String SID = request.getParameter("p_lid").trim();
//        String qry = "SELECT p.* , cr.`c_rqst_id`  FROM `customer_reg` c, `seller_reg` s, `property` p, `customer_request` cr  WHERE p.`p_id`=cr.`p_id` AND cr.`sr_id`=s.`sr_id` AND cr.`c_id`=c.`c_id` AND s.`sr_id`='" + SID + "' AND cr.`status`='REQUESTED'";
        String qry = "SELECT c.*, d.`d_name`, cr.`rqst_time`, vr.`type`, cr.`c_rqst_id`  FROM  `customer_request` cr, `customer_reg` c, `center_reg` vr,`doctor` d WHERE cr.`c_id` = c.`c_id` AND cr.`vr_id` = vr.`cr_id` AND vr.`type` = 'Veterinary' AND cr.`d_id` = d.`d_id` AND vr.`cr_id` = '" + SID + "' AND cr.`status` = 'REQUESTED'";
        System.out.println("qry=" + qry);
        JSONArray array = new JSONArray();
        Iterator it = conn.getData(qry).iterator();
        if (it.hasNext()) {
            while (it.hasNext()) {
                Vector v = (Vector) it.next();
                JSONObject obj = new JSONObject();
                obj.put("cr_id", v.get(0).toString().trim());
                obj.put("s_name", v.get(1).toString().trim());
                obj.put("s_address", v.get(2).toString().trim());
                obj.put("s_phone", v.get(3).toString().trim());
                obj.put("s_email", v.get(4).toString().trim());
                obj.put("s_doj", v.get(8).toString().trim());
                obj.put("s_status", v.get(7).toString().trim());
                obj.put("s_type", v.get(9).toString().trim() + "X");
                obj.put("c_rqst_id", v.get(10).toString().trim());
                array.add(obj);
            }
            out.println(array);
        } else {
            System.out.println("else id");
            out.print("failed");
        }
    }

//    ---------approveUserAppointment-------
    if (key.equals("approveUserAppointment")) {
        String UID = request.getParameter("u_id");
        String RQSTID = request.getParameter("rqst_id");

        String str = "UPDATE `customer_request` SET `status` = 'APPROVED' WHERE `vr_id` = '" + UID + "' AND `c_rqst_id` = '" + RQSTID + "'";
        if (conn.putData(str) > 0) {
            out.print("success");
        } else {
            out.print("failed");
        }

    }


    //    ---------getApprovedAppointments-------
    if (key.equals("getApprovedAppointments")) {
        String SID = request.getParameter("p_lid").trim();
//        String qry = "SELECT p.* , cr.`c_rqst_id`  FROM `customer_reg` c, `seller_reg` s, `property` p, `customer_request` cr  WHERE p.`p_id`=cr.`p_id` AND cr.`sr_id`=s.`sr_id` AND cr.`c_id`=c.`c_id` AND s.`sr_id`='" + SID + "' AND cr.`status`='REQUESTED'";
        String qry = "SELECT c.*, d.`d_name`, cr.`rqst_time`, vr.`type`, cr.`c_rqst_id`  FROM  `customer_request` cr, `customer_reg` c, `center_reg` vr,`doctor` d WHERE cr.`c_id` = c.`c_id` AND cr.`vr_id` = vr.`cr_id` AND vr.`type` = 'Veterinary' AND cr.`d_id` = d.`d_id` AND vr.`cr_id` = '" + SID + "' AND cr.`status` = 'APPROVED'";
        System.out.println("qry=" + qry);
        JSONArray array = new JSONArray();
        Iterator it = conn.getData(qry).iterator();
        if (it.hasNext()) {
            while (it.hasNext()) {
                Vector v = (Vector) it.next();
                JSONObject obj = new JSONObject();
                obj.put("cr_id", v.get(0).toString().trim());
                obj.put("s_name", v.get(1).toString().trim());
                obj.put("s_address", v.get(2).toString().trim());
                obj.put("s_phone", v.get(3).toString().trim());
                obj.put("s_email", v.get(4).toString().trim());
                obj.put("s_doj", v.get(8).toString().trim());
                obj.put("s_status", v.get(7).toString().trim());
                obj.put("s_type", v.get(9).toString().trim() + "X");
                obj.put("c_rqst_id", v.get(10).toString().trim());
                array.add(obj);
            }
            out.println(array);
        } else {
            System.out.println("else id");
            out.print("failed");
        }
    }

    //    ---------getRequestUserVeterinary-------
    if (key.equals("getRequestUserVeterinary")) {
        String SID = request.getParameter("p_lid").trim();
//        String qry = "SELECT p.* , cr.`c_rqst_id`  FROM `customer_reg` c, `seller_reg` s, `property` p, `customer_request` cr  WHERE p.`p_id`=cr.`p_id` AND cr.`sr_id`=s.`sr_id` AND cr.`c_id`=c.`c_id` AND s.`sr_id`='" + SID + "' AND cr.`status`='REQUESTED'";
        String qry = "SELECT d.* FROM `customer_request` cr, `doctor` d, `customer_reg` c, `center_reg` vr WHERE cr.`c_id` = c.`c_id` AND cr.`vr_id` = vr.`cr_id` AND vr.`type` = 'Veterinary' AND cr.`d_id` = d.`d_id` AND cr.`c_id` = '" + SID + "' AND cr.`status` = 'REQUESTED'";
        System.out.println("qry=" + qry);
        JSONArray array = new JSONArray();
        Iterator it = conn.getData(qry).iterator();
        if (it.hasNext()) {
            while (it.hasNext()) {
                Vector v = (Vector) it.next();
                JSONObject obj = new JSONObject();
                obj.put("d_id", v.get(0).toString().trim());
                obj.put("d_vid", v.get(1).toString().trim());
                obj.put("d_name", v.get(2).toString().trim());
                obj.put("d_age", v.get(3).toString().trim());
                obj.put("d_phone", v.get(4).toString().trim());
                obj.put("d_address", v.get(5).toString().trim());
                obj.put("d_qualification", v.get(6).toString().trim());
                obj.put("d_email", v.get(7).toString().trim());
                obj.put("d_timing", v.get(8).toString().trim());
                obj.put("d_image", v.get(9).toString().trim());
                array.add(obj);
            }
            out.println(array);
        } else {
            System.out.println("else id");
            out.print("failed");
        }
    }

    //    ---------getRequestApprovedUserVeterinary-------
    if (key.equals("getRequestApprovedUserVeterinary")) {
        String SID = request.getParameter("p_lid").trim();
//        String qry = "SELECT p.* , cr.`c_rqst_id`  FROM `customer_reg` c, `seller_reg` s, `property` p, `customer_request` cr  WHERE p.`p_id`=cr.`p_id` AND cr.`sr_id`=s.`sr_id` AND cr.`c_id`=c.`c_id` AND s.`sr_id`='" + SID + "' AND cr.`status`='REQUESTED'";
        String qry = "SELECT d.* FROM `customer_request` cr, `doctor` d, `customer_reg` c, `center_reg` vr WHERE cr.`c_id` = c.`c_id` AND cr.`vr_id` = vr.`cr_id` AND vr.`type` = 'Veterinary' AND cr.`d_id` = d.`d_id` AND cr.`c_id` = '" + SID + "' AND cr.`status` = 'APPROVED'";
        System.out.println("qry=" + qry);
        JSONArray array = new JSONArray();
        Iterator it = conn.getData(qry).iterator();
        if (it.hasNext()) {
            while (it.hasNext()) {
                Vector v = (Vector) it.next();
                JSONObject obj = new JSONObject();
                obj.put("d_id", v.get(0).toString().trim());
                obj.put("d_vid", v.get(1).toString().trim());
                obj.put("d_name", v.get(2).toString().trim());
                obj.put("d_age", v.get(3).toString().trim());
                obj.put("d_phone", v.get(4).toString().trim());
                obj.put("d_address", v.get(5).toString().trim());
                obj.put("d_qualification", v.get(6).toString().trim());
                obj.put("d_email", v.get(7).toString().trim());
                obj.put("d_timing", v.get(8).toString().trim());
                obj.put("d_image", v.get(9).toString().trim());
                array.add(obj);
            }
            out.println(array);
        } else {
            System.out.println("else id");
            out.print("failed");
        }
    }

//    ---------approveDogWalkerAppointment-------
    if (key.equals("approveDogWalkerAppointment")) {
        String UID = request.getParameter("u_id");
        String RQSTID = request.getParameter("rqst_id");

        String str = "UPDATE `dogwalker_request` SET `status` = 'APPROVED' WHERE `dw_id` = '" + UID + "' AND `wr_rqst_id` = '" + RQSTID + "'";
        String qry = "UPDATE `dogwalker_reg` SET `status` = 'WORKING' WHERE `dw_id` = '"+UID+"'"; 
        
        if (conn.putData(str) > 0 && conn.putData(qry) > 0) {
            out.print("success");
        } else {
            out.print("failed");
        }

    }

    //    ---------getApprovedDogWalker-------
    if (key.equals("getApprovedDogWalker")) {
        String SID = request.getParameter("p_lid").trim();
        String TYPE = request.getParameter("t_ype").trim();
//        String qry = "SELECT p.* , cr.`c_rqst_id`  FROM `customer_reg` c, `seller_reg` s, `property` p, `customer_request` cr  WHERE p.`p_id`=cr.`p_id` AND cr.`sr_id`=s.`sr_id` AND cr.`c_id`=c.`c_id` AND s.`sr_id`='" + SID + "' AND cr.`status`='REQUESTED'";
        String qry = "SELECT c.*, dr.`wr_rqst_id`, dr.`status`, dr.`rqst_time` FROM `dogwalker_request` dr, `customer_reg` c, `dogwalker_reg` dw WHERE dr.`dw_id` = dw.`dw_id` AND dr.`c_id` = c.`c_id` AND dr.`dw_id` = '" + SID + "' AND dr.`status` = 'APPROVED'";
        System.out.println("qry=" + qry);
        JSONArray array = new JSONArray();
        Iterator it = conn.getData(qry).iterator();
        if (it.hasNext()) {
            while (it.hasNext()) {
                Vector v = (Vector) it.next();
                JSONObject obj = new JSONObject();
                obj.put("dw_id", v.get(0).toString().trim());
                obj.put("dw_name", v.get(1).toString().trim());
                obj.put("dw_address", v.get(2).toString().trim());
                obj.put("dw_phone", v.get(3).toString().trim());
                obj.put("dw_email", v.get(4).toString().trim());
                obj.put("dw_doj", v.get(9).toString().trim());
                obj.put("c_rqst_id", v.get(7).toString().trim());
                obj.put("Xstatus", v.get(8).toString().trim());
                obj.put("type", TYPE + "XY");
                array.add(obj);
            }
            out.println(array);
        } else {
            System.out.println("else id");
            out.print("failed");
        }
    }
    


//    ---------removeRequest-------
    if (key.equals("removeRequest")) {
        String UID = request.getParameter("u_id");
        String PID = request.getParameter("p_id");

        String str = "UPDATE `dogwalker_request` SET `status` = 'COMPLETED' WHERE `wr_rqst_id` = '" + PID + "'";
        String qry = "UPDATE `dogwalker_reg` SET `status` = 'FREE' WHERE `dw_id` = '" + UID + "'";
        
        if (conn.putData(str) > 0 && conn.putData(qry) > 0) {
            out.print("success");
        } else {
            out.print("failed");
        }

    }

%>
