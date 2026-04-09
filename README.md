# NCEPU 学位论文 LaTeX 模板


## 1. 项目简介

本项目为 **华北电力大学（NCEPU）博士学位论文 LaTeX 模板**（面向**学术博士**和**专业博士**论文），依据学校学位论文相关格式规范设计与实现，支持 **Overleaf 在线编译** 与 **本地 LaTeX 环境**。模板希望为同学们提供一个**规范、稳定、易维护**的排版起点，尽量减少在格式细节上的反复消耗，让作者把精力更多放在论文内容与学术表达上。

更完整的使用说明请参考随附《华电博士论文LaTeX说明文档.pdf》文档。

## 2. 设计来源与致谢

本模板在设计理念与部分实现上，参考并借鉴了社区中已有的开源学位论文 LaTeX 模板（如 _NCUT Thesis LaTeX Template_ 等）。在此基础上，结合华北电力大学论文撰写与排版的实际需求，对整体结构、样式细节与使用方式进行了重新设计与定制开发。感谢相关开源项目作者对学术社区的贡献。

## 3. 发起与维护

本项目在 **华北电力大学网络与信息化工作处** 的支持下启动，由 **控制与计算机工程学院博士生闫慧如** 在 **程龙老师** 指导下完成核心开发。项目建设过程中，也获得了 **华北电力大学控制与计算机工程学院**、**研究生院** 等单位的支持与帮助。感谢所有提出建议、提交反馈、协助测试的老师与同学——欢迎更多贡献，一起把模板打磨得更好用、更可靠。


## 4. 项目结构说明

```text
.
├── main.tex                  % 主控文件（必须编译）
├── chapters/                 % 正文章节（每章一个 .tex 文件）
├── others/                   % 摘要、参考文献、致谢等
│   ├── abstractzh.tex
│   ├── abstracten.tex
│   └── reference.bib
├── figures/                  % 正文插图
├── figure_for_NCEPU/          % 封面所需图片（无需修改）
├── tools/                    % 模板配套工具
├── NCEPUDoctor.cls            % 博士论文样式文件（勿改）
└── NCEPUMaster.cls            % 硕士论文样式文件（勿改）
```

## 5. 问题反馈与维护
如在使用过程中发现格式问题、缺失样式或其他疑问，欢迎加入《华电博士论文LaTeX说明文档.pdf》中微信群反馈。
> 模板将根据同学们的反馈进行持续维护与更新，感谢支持！
---

## 6. 版本更新

-   v1.0: 2025/12/26，初始版本
-   v2.0: 2026/03/09，版本完善
-   v3.0: 2026/03/15，版本完善
-   v4.0: 2026/04/9，版本完善

---
## 7. 版本更新情况
-  v2.0完善：
    -  表格部分完善（具体使用代码见chapters/chapter5.tex），完善了表格缩放带来的字体变化问题，新增了对表格各列的宽度设置，并在代码使用部分添加了详细注释
    -  附录部分完善（具体使用代码见main.tex）
    -  新增图表清单、符号表（具体使用代码见main.tex），可根据需要添加
    -  英文摘要标题加粗（others/abstracten.tex第一行）
    -  main.tex中导入的包进行了修改
    -  完善了封面页英文标题的字号设置: 如果英文标题过长，应该使用小2号字体（Ltitle设置为False）; 如果英文标题正常长度，应该使用2号字体（Ltitle设置为True）
    -  修改文件：cls样式文件、main.tex、others/abstracten.tex、others文件夹下新增了nomenclature.tex（符号表）、appendix.tex（附录）
      
-  v3.0完善：
    -  参考文献：修改了期刊的引用格式，同时给出了10种参考文献条目的举例，对应见《关于参考文献的引用示例介绍.docx》文件
    -  更新文件：cls样式文件、tools/gbt7714-numerical.bst、chapters/chapter6.tex(参考文献引用示例)、others/reference.bib(参考文献引用示例)
    
-  v4.0完善：
    -  参考文献：文献作者的显示格式（例如，从Gross S, Massa F改成了Gross S., Massa F.）；完善了会议论文的引用规则，通过 isbn 字段区分有 ISBN 号的论文集与普通会议论文——有 ISBN 号时添加该字段，没有则省略。示例如下：@inproceedings{xia2002analysis,
        title={Analysis of Affective Characteristics and Evaluation of Harmonious Feeling of Image Based on  1/f Fluctuation Theory},
       ……
        isbn={978-3-540-48035-8}  % 若无 ISBN 则删除此行
    }
    -  排版细节调整： 优化了图片、表格与正文之间的前后间距；表格各列设置为垂直居中对齐
    -  算法示例：在 chapter3.tex 中提供了算法的示例代码，仅供参考
    -  中英文摘要部分新增了分散对齐格式，有需要可以自行调整
    -  涉及更新的文件： cls 样式文件、tools/gbt7714-numerical.bst、chapter3.tex
    -  更新了GitHub 仓库链接：https://github.com/NCEPU-LaTeX/Doctor_template，后续将通过官网与 GitHub 同步更新。