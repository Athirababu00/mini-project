package com.syntax.petvet.PETSHOP.ui;

import android.app.AlertDialog;
import android.content.DialogInterface;
import android.content.SharedPreferences;
import android.os.Bundle;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.AdapterView;
import android.widget.ImageView;
import android.widget.ListView;
import android.widget.Toast;

import androidx.annotation.NonNull;
import androidx.fragment.app.Fragment;
import androidx.fragment.app.FragmentTransaction;

import com.android.volley.Request;
import com.android.volley.Response;
import com.android.volley.VolleyError;
import com.android.volley.toolbox.StringRequest;
import com.android.volley.toolbox.Volley;
import com.google.gson.Gson;
import com.syntax.petvet.COMMON.RequestAdapterPet;
import com.syntax.petvet.COMMON.RequestPojo;
import com.syntax.petvet.R;
import com.syntax.petvet.USER.ui.ViewRequestPetshop;
import com.syntax.petvet.Utility;

import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static android.content.Context.MODE_PRIVATE;

public class ViewRequestPet extends Fragment {

    ListView listView;
    ImageView nodata;
    List<RequestPojo> requestPojoList;
    String pID, rqst_id;

    public View onCreateView(@NonNull LayoutInflater inflater,
                             ViewGroup container, Bundle savedInstanceState) {

        View root = inflater.inflate(R.layout.fragment_view_request_pet, container, false);

        listView = root.findViewById(R.id.pet_appointmentView);
        nodata = root.findViewById(R.id.noData);

        getAppointments();

        listView.setOnItemClickListener(new AdapterView.OnItemClickListener() {
            @Override
            public void onItemClick(AdapterView<?> parent, View view, final int position, long id) {



                AlertDialog.Builder builder = new AlertDialog.Builder(getContext());
                builder.setMessage("Do you want to Approve or Reject")
                        .setCancelable(false)
                        .setPositiveButton("Approve", new DialogInterface.OnClickListener() {
                            public void onClick(DialogInterface dialog, int id) {

                                rqst_id=requestPojoList.get(position).getPr_rqst();
                                approveRequest();

                            }
                        }).setNegativeButton("Reject", new DialogInterface.OnClickListener() {
                    public void onClick(DialogInterface dialog, int id) {
                        rqst_id=requestPojoList.get(position).getPr_rqst();
                        deleteCustomerRqst();
                    }
                })
                        .setNeutralButton("Cancel", new DialogInterface.OnClickListener() {
                            public void onClick(DialogInterface dialog, int id) {
                                dialog.cancel();
                            }
                        });
                AlertDialog alert = builder.create();
                alert.setTitle("PetVet");
                alert.show();
            }
        });

        return root;
    }

    public void getAppointments() {
        com.android.volley.RequestQueue queue = Volley.newRequestQueue(getContext());
        StringRequest request = new StringRequest(Request.Method.POST, Utility.SERVERUrl, new Response.Listener<String>() {
            @Override
            public void onResponse(String response) {
                Log.d("******", response);
                if (!response.trim().equals("failed")) {
                    Gson gson = new Gson();
                    requestPojoList = Arrays.asList(gson.fromJson(response, RequestPojo[].class));

                    RequestAdapterPet adapter = new RequestAdapterPet(getActivity(), requestPojoList);
                    listView.setAdapter(adapter);
                    registerForContextMenu(listView);
                } else {
//                    nodata.setBackgroundResource(no_data_found);
                    Toast.makeText(getContext(), "No Products Added", Toast.LENGTH_LONG).show();
                }
            }
        }, new Response.ErrorListener() {
            @Override
            public void onErrorResponse(VolleyError error) {

                Toast.makeText(getContext(), "my Error :" + error, Toast.LENGTH_LONG).show();
                Log.i("My Error", "" + error);
            }
        }) {
            @Override
            protected Map<String, String> getParams() {
                SharedPreferences prefs = getContext().getSharedPreferences("SharedData", MODE_PRIVATE);
                final String uid = prefs.getString("u_id", "No logid");//"No name defined" is the default value.
                Map<String, String> map = new HashMap<String, String>();
                map.put("key", "getRequestPet");
                map.put("p_lid", uid);

                return map;
            }
        };
        queue.add(request);
    }


    public void approveRequest() {
        com.android.volley.RequestQueue queue = Volley.newRequestQueue(getContext());
        StringRequest request = new StringRequest(Request.Method.POST, Utility.SERVERUrl, new Response.Listener<String>() {
            @Override
            public void onResponse(String response) {
                Log.d("******", response);
                if (!response.trim().equals("failed")) {

                    Toast.makeText(getContext(), "Request Approved", Toast.LENGTH_SHORT).show();
                    ViewRequestPetshop fragment = new ViewRequestPetshop();
                    FragmentTransaction transaction = getFragmentManager().beginTransaction();
                    transaction.replace(R.id.nav_host_fragment, fragment);
                    transaction.commit();

                } else {
//                    nodata.setBackgroundResource(no_data_found);
                    Toast.makeText(getContext(), "failed", Toast.LENGTH_LONG).show();
                }
            }
        }, new Response.ErrorListener() {
            @Override
            public void onErrorResponse(VolleyError error) {

                Toast.makeText(getContext(), "my Error :" + error, Toast.LENGTH_LONG).show();
                Log.i("My Error", "" + error);
            }
        }) {
            @Override
            protected Map<String, String> getParams() {
                SharedPreferences prefs = getContext().getSharedPreferences("SharedData", MODE_PRIVATE);
                final String uid = prefs.getString("u_id", "No logid");//"No name defined" is the default value.
                Map<String, String> map = new HashMap<String, String>();
                map.put("key", "approvePetRequest");
                map.put("u_id", uid);
                map.put("rqst_id", rqst_id);

                return map;
            }
        };
        queue.add(request);
    }

    public void deleteCustomerRqst() {
        com.android.volley.RequestQueue queue = Volley.newRequestQueue(getContext());
        StringRequest request = new StringRequest(Request.Method.POST, Utility.SERVERUrl, new Response.Listener<String>() {
            @Override
            public void onResponse(String response) {
                Log.d("******", response);
                if (!response.trim().equals("failed")) {

                    Toast.makeText(getContext(), "Request Rejected", Toast.LENGTH_SHORT).show();
                    ViewRequestPetshop fragment = new ViewRequestPetshop();
                    FragmentTransaction transaction = getFragmentManager().beginTransaction();
                    transaction.replace(R.id.nav_host_fragment, fragment);
                    transaction.commit();
                } else {
//                    nodata.setBackgroundResource(no_data_found);
                    Toast.makeText(getContext(), "failed", Toast.LENGTH_LONG).show();
                }
            }
        }, new Response.ErrorListener() {
            @Override
            public void onErrorResponse(VolleyError error) {

                Toast.makeText(getContext(), "my Error :" + error, Toast.LENGTH_LONG).show();
                Log.i("My Error", "" + error);
            }
        }) {
            @Override
            protected Map<String, String> getParams() {
                SharedPreferences prefs = getContext().getSharedPreferences("SharedData", MODE_PRIVATE);
                final String uid = prefs.getString("u_id", "No logid");//"No name defined" is the default value.
                Map<String, String> map = new HashMap<String, String>();
                map.put("key", "deletePetRqst");
                map.put("u_id", uid);
                map.put("rqst_id", rqst_id);

                return map;
            }
        };
        queue.add(request);
    }

}
