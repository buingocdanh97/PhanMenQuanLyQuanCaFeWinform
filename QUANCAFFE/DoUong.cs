//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace QUANCAFFE
{
    using System;
    using System.Collections.Generic;
    using System.Linq;

    public  partial class DoUong
    {
        DBQUANCAFFEDataContext dc = new DBQUANCAFFEDataContext();
        //        IDDoUong int
        //TenDoUong   nvarchar(50)
        //IDLoai int
        //SoLuong int
        //GiaGoc  float
        //GiaBan  float
        //NgayNhapHang    date
        //DonViTinh   nvarchar(50)


        private int idDoUuong;
        private string tenDoUong;
        private int idLoai;
        private int soLuong;
        private double giaGoc;
        private DateTime ngayNhapHang;
        private string donViTinh;

        public List<DoUong> DSDU()
        {

            return dc.DoUongs.ToList();
            
        }
    }
}
