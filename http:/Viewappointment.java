package com.syntax.petvet.CENTERS.ui;

import android.content.ContentValues;
import android.content.Intent;
import android.content.SharedPreferences;
import android.database.Cursor;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.net.Uri;
import android.os.Bundle;
import android.provider.MediaStore;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.EditText;
import android.widget.ImageView;
import android.widget.Toast;

import androidx.annotation.NonNull;
import androidx.fragment.app.Fragment;
import androidx.fragment.app.FragmentTransaction;

import com.android.volley.AuthFailureError;
import com.android.volley.Request;
import com.android.volley.RequestQueue;
import com.android.volley.Response;
import com.android.volley.VolleyError;
import com.android.volley.toolbox.StringRequest;
import com.android.volley.toolbox.Volley;
import com.syntax.petvet.COMMON.Base64;
import com.syntax.petvet.R;
import com.syntax.petvet.Utility;

import java.io.ByteArrayOutputStream;
import java.util.HashMap;
import java.util.Map;

import static android.app.Activity.RESULT_CANCELED;
import static android.app.Activity.RESULT_OK;
import static android.content.Context.MODE_PRIVATE;

public class AddDoctor extends Fragment {
    String DADDR, DNAME, DAGE, DPHONE, DEMAIL, DTIMING, DQUAL;
    EditText doctor, d_age, d_phone, d_email, d_timing, d_qual, d_addr;
    Button addproduct;


    ImageView imageView3, imgcam, imggal;
    Uri imageUri;
    private static final int PICK_IMAGE = 1;
    private static final int PICK_Camera_IMAGE = 2;
    private Bitmap bitmap;
    String bal = "null";

    public View onCreateView(@NonNull LayoutInflater inflater,
                             ViewGroup container, Bundle savedInstanceState) {

        View root = inflater.inflate(R.layout.add_doctor, container, false);



        doctor =(EditText)root.findViewById(R.id.doctor_name);
        d_age =(EditText)root.findViewById(R.id.doctor_age);
        d_phone =(EditText)root.findViewById(R.id.doctor_phone);
        d_email =(EditText)root.findViewById(R.id.doctor_email);
        d_timing =(EditText) root.findViewById(R.id.doctor_timing);
        d_qual =(EditText) root.findViewById(R.id.doctor_qual);
        d_addr = root.findViewById(R.id.doctor_addr);
        imageView3 = root.findViewById(R.id.imageView3);
        imgcam = root.findViewById(R.id.property_camera);
        imggal = root.findViewById(R.id.property_gal);


        imgcam.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                String fileName = "new-photo-name.jpg";
                //create parameters for Intent with filename
                ContentValues values = new ContentValues();
                values.put(MediaStore.Images.Media.TITLE, fileName);
                values.put(MediaStore.Images.Media.DESCRIPTION, "Image captured by camera");
                //imageUri is the current activity attribute, define and save it for later usage (also in onSaveInstanceState)
                imageUri = getContext().getContentResolver().insert(MediaStore.Images.Media.EXTERNAL_CONTENT_URI, values);
                //create new Intent
                Intent intent = new Intent(MediaStore.ACTION_IMAGE_CAPTURE);
                intent.putExtra(MediaStore.EXTRA_OUTPUT, imageUri);
                intent.putExtra(MediaStore.EXTRA_VIDEO_QUALITY, 1);
                startActivityForResult(intent, PICK_Camera_IMAGE);
            }
        });

        imggal.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                // TODO Auto-generated method stub
                // TODO Auto-generated method stub
                try {
                    Intent gintent = new Intent();
                    gintent.setType("image/*");
                    gintent.setAction(Intent.ACTION_GET_CONTENT);
                    startActivityForResult(Intent.createChooser(gintent, "Select Picture"), PICK_IMAGE);

                } catch (Exception e) {
                    Toast.makeText(getContext(), e.getMessage(), Toast.LENGTH_LONG).show();
                    Log.e(e.getClass().getName(), e.getMessage(), e);
                }
            }
        });

        addproduct =(Button) root.findViewById(R.id.add_prdct_btn);

        addproduct.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {

                DNAME = doctor.getText().toString().trim();
                DAGE = d_age.getText().toString().trim();
                DTIMING = d_timing.getText().toString().trim();
                DQUAL = d_qual.getText().toString().trim();
                DPHONE = d_phone.getText().toString().trim();
                DEMAIL = d_email.getText().toString().trim();
                DADDR = d_addr.getText().toString().trim();

                if (DNAME.isEmpty()) {
                    doctor.requestFocus();
                    doctor.setError("Enter Doctor Name");
                }else if (DAGE.isEmpty()) {
                    d_age.requestFocus();
                    d_age.setError("Enter Age");
                }else if (DTIMING.isEmpty()) {
                    d_timing.requestFocus();
                    d_timing.setError("Enter Timing");
                }else if (DQUAL.isEmpty()) {
                    d_qual.requestFocus();
                    d_qual.setError("Enter Qualification");
                }else  if (DPHONE.isEmpty()) {
                    d_phone.requestFocus();
                    d_phone.setError("Enter Phone");
                }else  if (DEMAIL.isEmpty()) {
                    d_email.requestFocus();
                    d_email.setError("Enter an email");
                }else if (DADDR.isEmpty()) {
                    d_addr.requestFocus();
                    d_addr.setError("Enter Address");
                }else if (bal.matches("null")){
                    imageView3.requestFocus();
                    Toast.makeText(getContext(), "Please Select Product image", Toast.LENGTH_SHORT).show();
                }else{
                    addDoctor();
                }

            }
        });

        return root;
    }


    public void onActivityResult(int requestCode, int resultCode, Intent data) {
        // TODO Auto-generated method stub
        Uri selectedImageUri = null;
        String filePath = null;
        switch (requestCode) {
            case PICK_IMAGE:
                if (resultCode == RESULT_OK) {
                    selectedImageUri = data.getData();
                }
                break;
            case PICK_Camera_IMAGE:
                if (resultCode == RESULT_OK) {
                    //use imageUri here to access the image
                    selectedImageUri = imageUri;
		 		    	/*Bitmap mPic = (Bitmap) data.getExtras().get("data");
						selectedImageUri = Uri.parse(MediaStore.Images.Media.insertImage(getContentResolver(), mPic, getResources().getString(R.string.app_name), Long.toString(System.currentTimeMillis())));*/
                } else if (resultCode == RESULT_CANCELED) {
                    Toast.makeText(getContext(), "Picture was not taken", Toast.LENGTH_SHORT).show();
                } else {
                    Toast.makeText(getContext(), "Picture was not taken", Toast.LENGTH_SHORT).show();
                }
                break;
        }

        if (selectedImageUri != null) {
            try {
                // OI FILE Manager
                String filemanagerstring = selectedImageUri.getPath();

                // MEDIA GALLERY
                String selectedImagePath = getPath(selectedImageUri);

                if (selectedImagePath != null) {
                    filePath = selectedImagePath;
                } else if (filemanagerstring != null) {
                    filePath = filemanagerstring;
                } else {
                    Toast.makeText(getContext(), "Unknown path",
                            Toast.LENGTH_LONG).show();
                    Log.e("Bitmap", "Unknown path");
                }

                if (filePath != null) {
                    decodeFile(filePath);
                } else {
                    bitmap = null;
                }
            } catch (Exception e) {
                Toast.makeText(getContext(), "Internal error",
                        Toast.LENGTH_LONG).show();
                Log.e(e.getClass().getName(), e.getMessage(), e);
            }
        }
    }


    public void decodeFile(String filePath) {
        // Decode image size
        BitmapFactory.Options o = new BitmapFactory.Options();
        o.inJustDecodeBounds = true;
        BitmapFactory.decodeFile(filePath, o);

        // The new size we want to scale to
        final int REQUIRED_SIZE = 1024;

        // Find the correct scale value. It should be the power of 2.
        int width_tmp = o.outWidth, height_tmp = o.outHeight;
        int scale = 1;
        while (true) {
            if (width_tmp < REQUIRED_SIZE && height_tmp < REQUIRED_SIZE)
                break;
            width_tmp /= 2;
            height_tmp /= 2;
            scale *= 2;
        }

        // Decode with inSampleSize
        BitmapFactory.Options o2 = new BitmapFactory.Options();
        o2.inSampleSize = scale;
        bitmap = BitmapFactory.decodeFile(filePath, o2);

        imageView3.setImageBitmap(bitmap);

        //...
        Base64.InputStream is;
        BitmapFactory.Options bfo;
        Bitmap bitmapOrg;
        ByteArrayOutputStream bao;

        bfo = new BitmapFactory.Options();
        bfo.inSampleSize = 2;
        //bitmapOrg = BitmapFactory.decodeFile(Environment.getExternalStorageDirectory() + "/" + customImage, bfo);

        bao = new ByteArrayOutputStream();
        bitmap.compress(Bitmap.CompressFormat.JPEG, 50, bao);
        byte[] ba = bao.toByteArray();
        bal = Base64.encodeBytes(ba);
//        Toast.makeText(getContext(), bal, Toast.LENGTH_SHORT).show();


        //..

    }

    public String getPath(Uri uri) {
        String[] projection = {MediaStore.Images.Media.DATA};
        Cursor cursor = getActivity().managedQuery(uri, projection, null, null, null);
        if (cursor != null) {
            // HERE YOU WILL GET A NULLPOINTER IF CURSOR IS NULL
            // THIS CAN BE, IF YOU USED OI FILE MANAGER FOR PICKING THE MEDIA
            int column_index = cursor
                    .getColumnIndexOrThrow(MediaStore.Images.Media.DATA);
            cursor.moveToFirst();
            return cursor.getString(column_index);
        } else
            return null;
    }


    public void addDoctor() {

        RequestQueue queue = Volley.newRequestQueue(getContext());
        StringRequest request = new StringRequest(Request.Method.POST, Utility.SERVERUrl, new Response.Listener<String>() {
            @Override
            public void onResponse(String response) {
                Log.d("******",response);
                if(!response.trim().equals("failed"))
                {
                    Toast.makeText(getContext(), "Doctor Added Successful", Toast.LENGTH_LONG).show();
                    AddDoctor fragment = new AddDoctor();
                    FragmentTransaction transaction = getFragmentManager().beginTransaction();
                    transaction.replace(R.id.nav_host_fragment, fragment);
                    transaction.commit();


                }
                else
                {
                    Toast.makeText(getContext(), "Error in adding Doctor", Toast.LENGTH_LONG).show();
                }
            }
        }, new Response.ErrorListener() {
            @Override
            public void onErrorResponse(VolleyError error) {

                Toast.makeText(getContext(), "my error :" + error, Toast.LENGTH_LONG).show();
                Log.i("My error", "" + error);
            }
        }) {
            @Override
            protected Map<String, String> getParams() throws AuthFailureError {
                Map<String, String> map = new HashMap<String, String>();
                SharedPreferences prefs = getContext().getSharedPreferences("SharedData", MODE_PRIVATE);
                final String uid = prefs.getString("u_id", "No logid");//"No name defined" is the default value.
                map.put("key","addDoctor");
                map.put("uid",uid);
                map.put("p_name", DNAME);
                map.put("p_age", DAGE);
                map.put("p_phone", DPHONE);
                map.put("p_email", DEMAIL);
                map.put("p_time", DTIMING);
                map.put("p_qual", DQUAL);
                map.put("p_addr", DADDR);
                map.put("base_string", bal);


                return map;
            }
        };
        queue.add(request);
    }



}
