$(document).ready(function(){
$('#rent')
  .form({
    use: {
      identifier : 'rent_house[use]',
      rules: [
        {
          type   : 'empty',
          prompt : '請輸入類別'
        }
      ]
    },
    structure: {
      identifier : 'rent_house[structure]',
      rules: [
        {
          type   : 'empty',
          prompt : '請輸入格局'
        }
      ]
    },
    address: {
      identifier : 'rent_house[address]',
      rules: [
        {
          type   : 'empty',
          prompt : '請輸入地址'
        }
      ]
    },
    price: {
      identifier : 'rent_house[price]',
      rules: [
        {
          type   : 'empty',
          prompt : '請輸入月租'
        }
      ]
    },
    owner: {
      identifier : 'rent_house[owner]',
      rules: [
        {
          type   : 'empty',
          prompt : '請輸入聯絡人'
        }
      ]
    },
    tel: {
      identifier : 'rent_house[tel]',
      rules: [
        {
          type   : 'empty',
          prompt : '請輸入聯絡電話'
        }
      ]
    },
    breif: {
      identifier : 'rent_house[breif]',
      rules: [
        {
          type   : 'empty',
          prompt : '請輸入刊登資訊'
        }
      ]
    }
  },{
    on: 'blur',
    inline: 'true',
    onSuccess : function() {
    }
  })
});
  