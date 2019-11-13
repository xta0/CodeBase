package package_test

/*
1. 以首字母大写来表明可被package以外的代码访问
2. 代码的package可以和所在的目录不一致
3. 同一目录里的Go代码的package要保持一致
*/

/*
init

1. 在main函数执行前，所有依赖的package的init都会被执行
2. 不同包的init函数按照包导入的依赖关系决定执行顺序
3. 每个包可以有多个init函数
4. 包的每个源文件也可以有多个init函数
*/

/*
Remote Package

1. 通过 go get 获取远程依赖 - go get -u https://some_package.github.com
2. 在Github的源码需要严格遵循某种组织形式以适应 go get
*/
