package com.syntax.petvet.ADMIN.ui;

import android.content.SharedPreferences;
import android.os.Bundle;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.ListView;
import android.widget.Toast;

import androidx.annotation.NonNull;
import androidx.fragment.app.Fragment;

import com.android.volley.Request;
import com.android.volley.Response;
import com.android.volley.VolleyError;
import com.android.volley.toolbox.StringRequest;
import com.android.volley.toolbox.Volley;
import com.google.gson.Gson;
import com.syntax.petvet.COMMON.RequestAdapter;
import com.syntax.petvet.COMMON.RequestPojo;
import com.syntax.petvet.R;
import com.syntax.petvet.Utility;

import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static android.content.Context.MODE_PRIVATE;

public class ViewPetshop extends Fragment {

    ListView listView;
    ImageView nodata;
    String sID, rqst_id;

    List<RequestPojo> requestPojoList;

    public View onCreateView(@NonNull LayoutInflater inflater,
                             ViewGroup container, Bundle savedInstanceState) {

        View root = inflater.inflate(R.layout.view_petshop, container, false);

        listView = root.findViewById(R.id.viewCenter_ID);
        nodata = root.findViewById(R.id.noData);

        viewCenter();

        return root;
    }

    public void viewCenter() {
        com.android.volley.RequestQueue queue = Volley.newRequestQueue(getContext());
        StringRequest request = new StringRequest(Request.Method.POST, Utility.SERVERUrl, new Response.Listener<String>() {
            @Override
            public void onResponse(String response) {
                Log.d("******", response);
                if (!response.trim().equals("failed")) {
                    Gson gson = new Gson();
                    requestPojoList = Arrays.asList(gson.fromJson(response, RequestPojo[].class));

                    RequestAdapter adapter = new RequestAdapter(getActivity(), requestPojoList);
                    listView.setAdapter(adapter);
                    registerForContextMenu(listView);
                } else {
//                    nodata.setBackgroundResource(no_data_found);
                    Toast.makeText(getContext(), "No Data", Toast.LENGTH_LONG).show();
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
                map.put("key", "viewPetshop");
                map.put("s_lid", uid);

                return map;
            }
        };
        queue.add(request);
    }
}
