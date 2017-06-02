
/**
 * A custom adapter to use with the RecyclerView widget.
 */
public class ${adapterClass} extends RecyclerView.Adapter<${adapterClass}.${itemClass}> {

    private Context mContext;
    private ArrayList<${adapterModelClass}> modelList;

    <#if isItemClick>
    private OnItemClickListener mItemClickListener;
    </#if>
    <#if features == 'radio'>
    private int lastCheckedPosition = -1;
    </#if>
    public ${adapterClass}(Context context, ArrayList<${adapterModelClass}> modelList) {
            this.mContext = context;
            this.modelList = modelList;
    }

    public void updateList(ArrayList<${adapterModelClass}> modelList) {
            this.modelList = modelList;
            notifyDataSetChanged();

    }

    @Override
    public ${itemClass} onCreateViewHolder(ViewGroup viewGroup, int viewType) {

        View view = LayoutInflater.from(viewGroup.getContext()).inflate(R.layout.${itemLayoutName}, viewGroup, false);

        return new ${itemClass}(view);
    }

    @Override
     public void onBindViewHolder(ViewHolder holder, final int position) {

         //Here you can fill your row view

           ${adapterModelClass} model = getItem(position);

             holder.itemTxtTitle.setText(model.getTitle());
             holder.itemTxtMessage.setText(model.getMessage());

             <#if features == 'radio'>

             holder.radioList.setChecked(position == lastCheckedPosition);

             holder.radioList.setOnClickListener(new View.OnClickListener() {
              @Override
              public void onClick(View view) {

                  lastCheckedPosition = position;
                  notifyItemRangeChanged(0, modelList.size());

                  mItemClickListener.onItemClick(view, position,modelList.get(position));

              }
          });
          </#if>


     }

    @Override
    public int getItemCount() {

        return modelList.size();
    }


    private ${adapterModelClass} getItem (int position) {
       return modelList.get (position);
   }


    public class ${itemClass} extends RecyclerView.ViewHolder {

        private ImageView imgUser;
        private TextView itemTxtTitle;
        private TextView itemTxtMessage;
        <#if features == 'radio'>
        private RadioButton radioList;
        </#if>

        // @BindView(R.id.img_user)
        // ImageView imgUser;
        // @BindView(R.id.item_txt_title)
        // TextView itemTxtTitle;
        // @BindView(R.id.item_txt_message)
        // TextView itemTxtMessage;
        // @BindView(R.id.radio_list)
        // RadioButton itemTxtMessage;

        public ${itemClass}(final View itemView) {
            super(itemView);

            // ButterKnife.bind(this, itemView);

            this.imgUser = (ImageView) itemView.findViewById(R.id.img_user);
            this.itemTxtTitle = (TextView) itemView.findViewById(R.id.item_txt_title);
            this.itemTxtMessage = (TextView) itemView.findViewById(R.id.item_txt_message);
            <#if features == 'radio'>
            this.radioList = (RadioButton) itemView.findViewById(R.id.radio_list);
            </#if>

            <#if isItemClick>

            itemView.setOnClickListener(new View.OnClickListener() {
             @Override
             public void onClick(View view) {
            <#if features == 'radio'>
                 lastCheckedPosition = getAdapterPosition();
                 notifyItemRangeChanged(0, modelList.size());
            </#if>
                 mItemClickListener.onItemClick(itemView, getAdapterPosition(),modelList.get(getAdapterPosition()));
             }
         });

            </#if>
        }
    }

    <#if isItemClick>

        public interface OnItemClickListener {
                void onItemClick(View view, int position,${adapterModelClass} model);
        }

        public void SetOnItemClickListener(final OnItemClickListener mItemClickListener) {
                this.mItemClickListener = mItemClickListener;
        }
    </#if>



}
