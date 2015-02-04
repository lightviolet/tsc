function formCheck()
{
	var f = document.forms[0];
	var length = f.length;

	for (var i = 0; i < length; i++)
	{
		if (f[i].value == null || f[i].value == "")
		{
			alert(f[i].title + " 를(을) 입력해 주세요");
			f[i].focus();
			return false;
		}
	}

	f.submit();
}
