# 将当前目录以及子目录下的图片转成base64编码
# 输出结果中已经带了与图片类型相对应的data:image/imageType;base64,头
 
fs = require 'fs'

imgType = ['jpg', 'gif', 'png']

prefixTmpl = 'data:image/{format};base64,'

getBase64 = (path) ->

	fileList = fs.readdir path, (err, fileList) ->

		for fileName in fileList

			filePath = path + '/' + fileName
			fileStat = fs.statSync filePath
			
			if fileStat.isDirectory()
				getBase64 filePath
			else
				name = fileName.split('.')[0]
				ext = fileName.split('.')[1]
				continue if ext not in imgType
				txtFileName = name + '.txt'
				prefix = prefixTmpl.replace '{format}', ext
				file = fs.readFileSync filePath
				base64Content = file.toString 'base64'
				fs.writeFile path + '/' + txtFileName, prefix + base64Content

getBase64 '.'