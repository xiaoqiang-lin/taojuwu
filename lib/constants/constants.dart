class Constants {
  static const HOST = "http://106.14.219.213:8001";
  static const TRANSITION_DURATION = Duration(milliseconds: 300);
  //订单状态

  //order_status 订单状态 1待审核 2待测量 3待付款 4付款待审核 5生产中 6等待预约安装 7待安装 8已完成 9已取消 10售后维权 11售后维权已处理 12售后维权已关闭 -1退款中 13订单自动完成 14待选品' 15取消待审核
  static const String ORDER_STATUS_ALL = '全部';
  static const String ORDER_STATUS_TO_AUDIT = '待审核';
  static const String ORDER_STATUS_TO_MEASURE = '待测量';
  static const String ORDER_STATUS_TO_SELECT = '待选品';
  static const String ORDER_STATUS_PAY_TAIL = '付尾款';
  static const String ORDER_STATUS_PRODUCTING = '生产中';
  static const String ORDER_STATUS_TO_INSTALL = '待安装';
  static const String ORDER_STATUS_FINISHED = '已完成';

  static const String ORDER_STATUS_PRODUCTED = '生产完成';

  static const String ORDER_STATUS_PAIED_TO_AUDIT = '付尾款待审核';
  static const String ORDER_STATUS_TO_SCHEDULE_INSTALL = '等待预约安装';

  static const String ORDER_STATUS_TO_PAY = '待付款';

  static const String ORDER_STATUS_WAIT_TO_REFUND = '退款申请';

  static const ORDER_STATUS_TO_SELECT_CODE = 14;

  static const Map ORDER_STATUS_TAB_MAP = {
    '': ORDER_STATUS_ALL,
    '1': ORDER_STATUS_TO_AUDIT,
    '2': ORDER_STATUS_TO_MEASURE,
    '3': ORDER_STATUS_TO_SELECT,
    '4': ORDER_STATUS_PAY_TAIL,
    '5': ORDER_STATUS_PRODUCTING,
    '6': ORDER_STATUS_TO_INSTALL,
    '7': ORDER_STATUS_FINISHED,
  };

  static const Map ORDER_STATUS_MAP = {
    '': ORDER_STATUS_ALL,
    '1': ORDER_STATUS_ALL,
    '2': ORDER_STATUS_TO_AUDIT,
    '3': ORDER_STATUS_TO_MEASURE,
    '4': ORDER_STATUS_TO_SELECT,
    '5': ORDER_STATUS_PAY_TAIL,
    '6': ORDER_STATUS_PRODUCTING,
    '7': ORDER_STATUS_TO_INSTALL,
    '8': ORDER_STATUS_FINISHED,
  };

  static const Map ORDER_STATUS_BUTTON_ACTION = {
    0: {
      'show_button': false,
    },
    1: {'show_button': true, 'button_text': '提醒审核'},
    2: {'show_button': true, 'button_text': '提醒测量'},
    3: {'show_button': false},
    4: {'show_button': false},
    5: {'show_button': false},
    6: {'show_button': true, 'button_text': '提醒安装'},
    7: {'show_button': true, 'button_text': '售后维权'},
    8: {'show_button': true, 'button_text': '售后维权'},
    9: {'show_button': true, 'button_text': '提醒审核'},
    14: {'show_button': true, 'button_text': '去选品'}
  };

  static const Map<int, Map<String, String>> ORDER_STATUS_TIP_MAP = {
    -1: {'title': '退款申请已提交', 'subtitle': '等待审核'},
    0: {'title': '', 'subtitle': ''},
    1: {
      'title': '订单已提交',
      'subtitle': '等待审核',
    },
    2: {
      'title': '订单已审核',
      'subtitle': '等待测量人员上门测量',
    },
    3: {
      'title': '测量完成',
      'subtitle': '等待客户支付尾款',
    },

    4: {
      'title': '订单已付尾款',
      'subtitle': '等待审核',
    },

    // ORDER_STATUS_TO_PAY: {
    //   'title': '测量完成',
    //   'subtitle': '等待客户支付尾款',
    // },
    // ORDER_STATUS_PAIED_TO_AUDIT: {
    //   'title': '订单已付尾款',
    //   'subtitle': '等待审核',
    // },
    5: {
      'title': '审核完成',
      'subtitle': '商品正在工厂生产中',
    },
    6: {
      'title': '商品已准备完毕',
      'subtitle': '联系预约安装时间',
    },
    7: {
      'title': '已发货',
      'subtitle': '预约安装时间',
    },
    8: {'title': '交易成功', 'subtitle': ''},
    9: {'title': '已取消', 'subtitle': ''},
    10: {'title': '售后问题已提交', 'subtitle': '我们将尽快为您解决'},
    11: {'title': '交易完成', 'subtitle': '售后问题已处理'},
    14: {'title': '已完成测量', 'subtitle': '请根据房型选择商品'},
    15: {'title': '已完成测量', 'subtitle': '请根据房型选择商品'},
    // ORDER_STATUS_PRODUCTED: {'title': '交易成功', 'subtitle': ''},
  };

  static const Map<dynamic, String> GENDER_MAP = {
    '0': '未知',
    '1': '男',
    '2': '女',
    0: '未知',
    1: '男',
    2: '女'
  };

  static const Map<int, String> CUSTOMER_TYPE_MAP = {
    0: '初谈客户',
    1: '意向客户',
    2: '跟进客户',
    3: '成交客户'
  };

  static const Map<int, String> ATTR_MAP = {
    1: '空间',
    2: '窗型',
    3: '窗纱面料',
    4: '工艺',
    5: '配件',
    6: '帘身款式',
    7: '帘身面料',
    8: '幔头',
    9: '尺寸',
    12: '遮光里布',
    13: '配饰'
  };

  static const Map<String, int> ATTR2NUM_MAP = {
    '空间': 1,
    '窗型': 2,
    '窗纱面料': 3,
    '工艺': 4,
    '配件': 5,
    '帘身款式': 6,
    '帘身面料': 7,
    '馒头': 8,
    '尺寸': 9,
    '遮光里布': 12,
    '配饰': 13
  };

  static const SERVER_PROMISE = '''
  服务承诺:
  (1)未量尺前支持7天无理由退货换货；量尺后，取消订单则需承担套餐金额的违约金，具体已门店为准（若超服务范围需含远途路费，作为上门测量所产生的全部费用）；下单生产后，取消订单则需承担量尺、产品等费用。 
  (2)24小时售后响应制，2个工作日给予解决方案，最终以用户确认满意评价。 
  (3)客户满足测量条件（硬装结束，地板及门框安装完毕）预约测量；正式选品下单后，20天左右生产完成。
  ''';

  static const PRIVACY = '''
  在此特别提醒您（用户）在注册成为用户之前，请认真阅读本《用户协议》（以下简称“协议”），确保您充分理解本协议中各条款。请您审慎阅读并选择接受或不接受本协议。您的注册、登录、使用等行为将视为对本协议的接受，并同意接受本协议各项条款的约束。本协议约定杭州贝铭纺织品有限公司（以下简称“贝铭”）与用户之间关于“淘居屋”软件服务（以下简称“服务“）的权利义务。“用户”是指注册、登录、使用本服务的个人。本协议可由贝铭随时更新，更新后的协议条款一旦公布即代替原来的协议条款，恕不再另行通知，用户可在本APP中查阅最新版协议条款。在修改协议条款后，如果用户不接受修改后的条款，请立即停止使用“淘居屋”提供的服务，用户继续使用服务将被视为接受修改后的协议。 

 

阅读协议的过程中，如果您不同意相关协议或其中任何条款约定，您应立即停止注册程序。

 

一、 账户注册与使用

1.1用户资格

您确认，在您开始注册程序使用淘居屋服务前，您应当具备中华人民共和国法律规定的与您行为相适应的民事行为能力。若您不具备前述与您行为相适应的民事行为能力，则您及您的监护人应依照法律规定承担因此而导致的一切后果。

 

此外，您还需确保您不是任何国家、国际组织或者地域实施的贸易限制、制裁或其他法律、规则限制的对象，否则您可能无法正常注册及使用淘居屋服务。

 

1.2 账户说明

鉴于淘居屋账号绑定注册方式，您同意淘居屋在注册时将允许您的手机号码及设备识别号码等信息用于注册。

 

1.3注册信息管理

在使用淘居屋服务时，您应当按淘居屋页面的提示准确完整地提供您的信息（包括您的姓名及电子邮件地址、联系电话、联系地址等），以便淘居屋或其他用户与您联系。您了解并同意，您有义务保持您提供信息的真实性及有效性。

 

 

二、账户安全规范

2.1您的账户为您自行设置并由您保管，淘居屋任何时候均不会主动要求您提供您的账户密码。因此，建议您务必保管好您的账户，并确保您在每个上网时段结束时退出登录并以正确步骤离开淘居屋。账户因您主动泄露或因您遭受他人攻击、诈骗等行为导致的损失及后果，淘居屋并不承担责任，您应通过司法、行政等救济途径向侵权行为人追偿。

 

2.2除淘居屋存在过错外，您应对您账户项下的所有行为结果（包括但不限于在线签署各类协议、发布信息、购买商品及服务及披露信息等）负责。

 

2.3如发现任何未经授权使用您账户登录淘居屋或其他可能导致您账户遭窃、遗失的情况，建议您立即通知淘居屋。您理解淘居屋对您的任何请求采取行动均需要合理时间，且淘居屋应您请求而采取的行动可能无法避免或阻止侵害后果的形成或扩大，除淘居屋存在法定过错外，淘居屋不承担责任。

 

三、 淘居屋服务及规范

3.1淘居屋是由贝铭纺织品有限公司提供的家纺、家居用品类商品在线定制产品，展示产品，交易产品，管理门店及/或商品的平台。并提供家纺、家居用品类商品交易后配套的测量、安装服务。“淘居屋平台服务”以下简称“服务”包括但不限于：

 

3.11家纺、家居用品、窗帘定制产品的展示销售。

 

3.12定制产品价格计算参考

 

3.13测量、安装服务

 

3.14订单管理

 

3.15用户管理

 

3.16门店管理

 

3.2淘居提供的产品计算报价为参考依据，结算依据，用户通过淘居屋的交易以实际支付的金额为准。用户产生的交易纠纷与实际交易门店进行协商，与淘居屋无关。

 

3.3所有发给用户的通告及其他消息都可通过淘居屋或者用户提供的联系方式发送。

 

3.3当您在淘居屋购买商品及/或服务时，请您务必仔细确认所购商品的品名、价格、数量、型号、规格、尺寸或服务的时间、内容、限制性要求等重要事项，并在下单时核实您的联系地址、电话、收货人等信息。如您填写的收货人非您本人，则该收货人的行为和意思表示产生的法律后果均由您承担。

 

3.4您的购买行为应当基于真实的消费需求，不得存在对商品及/或服务实施恶意购买、恶意维权等扰乱淘居屋平台正常交易秩序的行为。基于维护淘居屋平台交易秩序及交易安全的需要，淘居屋发现上述情形时可主动执行关闭相关交易订单等操作。

 

3.5您在淘居屋交易过程中与其他用户发生争议的，您或其他用户中任何一方均有权选择以下途径解决：

3.51与争议相对方自主协商；

 

3.52通过淘居屋进行争议调处；

 

3.53请求消费者协会或者其他依法成立的调解组织调解；

 

3.54向有关行政部门投诉；

 

3.55根据与争议相对方达成的仲裁协议（如有）提请仲裁机构仲裁；

 

3.56向人民法院提起诉讼。

 

四、责任限制

淘居屋依照法律规定履行基础保障义务，但对于下述原因导致的合同履行障碍、履行瑕疵、履行延后或履行内容变更等情形，淘居屋并不承担相应的违约责任：

 

4.1因自然灾害、罢工、暴乱、战争、政府行为、司法行政命令等不可抗力因素；

 

4.2因电力供应故障、通讯网络故障等公共服务因素或第三人因素；

 

4.3在淘居屋已尽善意管理的情况下，因常规或紧急的设备与系统维护、设备与系统故障、网络信息与数据安全等因素。

 

 

五、用户隐私说明

5.1.您授权我们使用的信息。 包括但不限于当您注册淘居屋账户及您在使用淘居屋平台提供的相关服务时填写及/或提交的信息，包括您的姓名、性别、出生年月日、身份证号码、电话号码、电子邮箱、地址、账号及相关附加信息（如您所在的省份和城市、邮政编码等）。

 

5.2在您使用服务过程中收集的信息。为了提供并优化您需要的服务，我们会收集并使用您使用服务的相关信息，这类信息包括：

 

在您使用淘居屋服务，或访问淘居屋网页时，淘居屋自动接收并记录的您的浏览器和计算机上的信息，包括但不限于您的IP地址、浏览器的类型、使用的语言、访问日期和时间、软硬件特征信息及您需求的网页记录等数据；如您下载或使用淘居屋或其关联公司客户端软件，或访问移动网页使用淘居屋平台服务时，淘居屋可能会读取与您位置和移动设备相关的信息，包括但不限于设备型号、设备识别码、操作系统、分辨率、电信运营商等。

 

除上述信息外，我们还可能为了提供服务及改进服务质量的合理需要而收集您的其他信息，包括您与我们的客户服务团队联系时您提供的相关信息，您参与问卷调查时向我们发送的问卷答复信息，以及您与淘居屋的关联方、淘居屋合作伙伴之间互动时我们收集的相关信息。与此同时，为提高您使用淘居屋提供的服务的安全性，更准确地预防钓鱼网站欺诈和木马病毒，我们可能会通过了解一些您的网络使用习惯、您常用的软件信息等手段来判断您账户的风险，并可能会记录一些我们认为有风险的URL。

 

5.3.来自第三方的信息为了给您提供更好、更优、更加个性化的服务，或共同为您提供服务，或为了预防互联网欺诈的目的，淘居屋的关联方、合作伙伴会依据法律的规定或与您的约定或征得您同意的前提下，向淘居屋分享您的个人信息。

 

您了解并同意，以下信息不适用本隐私权政策：

 

a）您在使用淘居屋提供的搜索服务时输入的关键字信息；

 

b）淘居屋收集到的您在淘居屋进行交易的有关数据，包括但不限于出价、成交信息及评价详情；

 

c) 应法律法规要求需公示的企业名称等相关工商注册信息以及自然人经营者的信息。

 

5.4因收集您的信息是为了向您提供服务及提升服务质量的目的，为了实现这一目的，您同意并授权我们把您的信息用于下列用途：

 

5.41向您提供您使用的各项服务，并维护、改进这些服务。

 

5.42.向您推荐您可能感兴趣的内容，包括但不限于向您发出产品和服务信息，或通过系统向您展示个性化的第三方推广信息，或者在征得您同意的情况下与淘居屋的合作伙伴共享信息以便他们向您发送有关其产品和服务的信息。

 

5.43.我们可能使用您的个人信息以预防、发现、调查欺诈、危害安全、非法或违反与我们或其关联方协议、政策或规则的行为，以保护您、其他我们用户，或我们或其关联方的合法权益。

 

5.44.我们可能会将来自某项服务的个人信息与来自其他服务的信息结合起来，用于为了给您提供更加个性化的服务使用，例如让您拥有更广泛的社交圈的需要而使用、共享或披露。

 

5.45.经您许可的其他用途。

 

5.5我们对您的信息承担保密义务，不会为满足第三方的营销目的而向其出售或出租您的任何信息，我们会在下列情况下才将您的信息与第三方共享：

 

5.51.事先获得您的同意或授权。

 

5.52.根据法律法规的规定或行政或司法机构的要求。

 

5.53.向淘居屋的关联方分享您的个人信息。

 

5.54.向可信赖的合作伙伴提供您的个人信息，让他们根据我们的指示并遵循我们的隐私权政策以及其他任何相应的保密和安全措施来为我们处理这些信息。

 

5.55.如您是适格的知识产权投诉人并已提起投诉，应被投诉人要求，向被投诉人披露，以便双方处理可能的权利纠纷。

 

5.56.只有共享您的信息，才能提供您需要的服务，或处理您与他人的纠纷或争议。例如您在淘居屋上创建的某一交易中，如交易任何一方履行或部分履行了交易义务并提出信息披露请求的，淘居屋会视情况向该用户提供其交易对方的联络方式等必要信息，以促成交易的完成或纠纷的解决。

 

5.57.如您出现违反中国有关法律、法规或者淘居屋相关协议或相关规则的情况，需要向第三方披露。

 

5.58.为维护淘居屋及其关联方或用户的合法权益。

 

六、服务“按现状”提供

6.1贝铭公司不能随时预见到任何技术上的问题或其他困难。该等困难可能会导致数据损失或其他服务中断。为此，您明确理解和同意，您使用“淘居屋服务”的风险由您自行承担。淘居屋平台明确声明不作出任何种类的所有明示或暗示的保证，包括但不限于关于安全性、适用于某一特定用途和无侵权行为等方面的保证。淘居屋平台对下述内容不作保证：

(i) “服务”会符合您的要求；

(ii) “服务”不会中断，且适时、安全和不带任何错误；

(iii) 通过使用“服务”而可能获取的结果将是准确或可信赖的；

(iv) 您通过“服务”而获取的任何其他服务、资料或其他材料将符合您的预期。

6.2通过使用“服务”而下载或以其他形式获取任何材料是由您自行全权决定进行的，且与此有关的风险由您自行承担，对于因您下载任何该等材料而发生的您的电脑系统的任何损毁或任何数据损失，您将自行承担责任。您从淘居屋平台获取的任何资料，均不产生未在本协议内明确载明的任何保证。

6.3您理解，鉴于计算机、互联网的特殊性，下述情况不属于淘居屋平台违约：淘居屋平台在进行服务器配置、维护时，需要短时间中断服务；由于Internet上的通路阻塞造成您网站访问速度下降。如果因淘居屋平台原因造成您不能正常使用淘居屋平台服务的，请您及时向平台客服反映，并由客服端及时进行解决处理。

 

七、保密

7.1保密资料指由一方向另一方披露的所有技术及非技术信息（包括但不限于产品资料，产品计划，价格，财务及营销规划，业务战略，客户信息，客户数据，研发，软件硬件，API应用数据接口，技术说明，设计，特殊公式，特殊算法等）。

7.2本协议任何一方同意对获悉的对方之上述保密资料予以保密，并严格限制接触上述保密信息的员工遵守本条之保密义务。除非国家机关依法强制要求或上述保密资料已经进入公有领域外，接受保密资料的一方不得对外披露。

7.3本协议双方明确认可各自用户信息和业务数据等是各自的重要资产及重点保密信息。本协议双方同意尽最大的努力保护上述保密信息等不被披露。一旦发现有上述保密信息泄露事件，双方应合作采取一切合理措施避免或者减轻损害后果的产生。

7.4本条款不因本协议的终止而失效。

 

 

八、 法律适用、管辖与其他

8.1本协议之订立、生效、解释、修订、补充、终止、执行与争议解决均适用中华人民共和国大陆地区法律；如法律无相关规定的，参照商业惯例及/或行业惯例。

 

8.2您因使用淘居屋服务所产生及与淘居屋服务有关的争议，由淘居屋与您协商解决。协商不成时，任何一方均可向被告所在地人民法院提起诉讼。

 

8.3本协议任一条款被视为废止、无效或不可执行，该条应视为可分的且并不影响本协议其余条款的有效性及可执行性。

 

九、其他规定

10.1本协议条款标题仅为方便参阅而设，并不以任何方式界定、限制、解释或描述该条款的范围或限度。本贝铭未就您或其他人士的某项违约行为采取行动，并不表明本贝铭撤回就任何继后或类似的违约事件采取行动的权利。
  
  ''';
}
