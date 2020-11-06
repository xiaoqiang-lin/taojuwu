/*
 * @Description: 窗纱商品详情页面
 * @Author: iamsmiling
 * @Date: 2020-10-31 15:35:02
 * @LastEditTime: 2020-11-05 14:38:33
 */
import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:taojuwu/repository/shop/product_detail/curtain/gauze_curtain_product_detail_bean.dart';
import 'package:taojuwu/view/product/base/base_curtain_product_detail_state.dart';
import 'package:taojuwu/view/product/base/base_product_detail_state.dart';
import 'package:taojuwu/view/product/widgets/product_detail_footer.dart';
import 'package:taojuwu/view/product/widgets/product_detail_header.dart';
import 'package:taojuwu/view/product/widgets/product_detail_profile.dart';
import 'package:taojuwu/view/product/widgets/section/gauze_curtain_product_attrs_section_view.dart';
import 'package:taojuwu/view/product/widgets/section/product_detail_img_section_view.dart';
import 'package:taojuwu/view/product/widgets/section/recommend_product_section_view.dart';
import 'package:taojuwu/view/product/widgets/section/relative_product_section_view.dart';
import 'package:taojuwu/view/product/widgets/section/scene_design_product_section_view.dart';
import 'package:taojuwu/view/product/widgets/section/soft_design_product_section_view.dart';
import 'package:taojuwu/widgets/loading.dart';

class GauzeCurtainProductDetailPage extends BaseProductDetailPage {
  final int id;
  GauzeCurtainProductDetailPage(this.id, {Key key}) : super(id);

  @override
  _GauzeCurtainProductDetailPageState createState() =>
      _GauzeCurtainProductDetailPageState();
}

class _GauzeCurtainProductDetailPageState
    extends BaseCurtainProductDetailState<GauzeCurtainProductDetailPage> {
  // 发起请求
  Future sendRequest() {
    return fetchData(context, widget.goodsId).whenComplete(() {
      // 初始化商品属性
      (productDetailBean as GauzeCurtainProductDetailBean)?.fetchAttrsData(() {
        setState(() {
          isLoading = false;
        });
      });
    }).then((_) {
      (productDetailBean as GauzeCurtainProductDetailBean)
          .fetchRoomAttrData()
          .whenComplete(() {
        copyData();
      });
    }).catchError((err) => err);
  }

  @override
  Widget build(BuildContext context) {
    return PageTransitionSwitcher(
        transitionBuilder: (
          Widget child,
          Animation<double> animation,
          Animation<double> secondaryAnimation,
        ) {
          return FadeThroughTransition(
            animation: animation,
            secondaryAnimation: secondaryAnimation,
            child: child,
          );
        },
        child: isLoading
            ? LoadingCircle()
            : Scaffold(
                backgroundColor: const Color(0xFFF8F8F8),
                body: NestedScrollView(
                    controller: scrollController,
                    headerSliverBuilder:
                        (BuildContext context, bool innerBoxIsScrolled) {
                      return <Widget>[ProductDetailHeader(productDetailBean)];
                    },
                    body: CustomScrollView(
                      shrinkWrap: true,
                      slivers: [
                        ProductDetailProfile(productDetailBean),
                        GauzeCurtainProductAttrsSectionView(productDetailBean),
                        SliverToBoxAdapter(
                          child: ProductDetailImgSectionView(
                              productDetailBean?.detailImgList),
                        ),
                        // RollingCurtainProductAttrsSectionView(ProductDetailBean),
                        // RollingCurtainProductAttrSectionView(ProductDetailBean),
                        RelativeProductSectionView(relativeProductList),
                        SliverToBoxAdapter(
                          child: SceneDesignProductSectionView(
                              sceneDesignProductList),
                        ),
                        SliverToBoxAdapter(
                          child: SoftDesignProductSectionView(
                            softDesignProductList,
                            goodsId: productDetailBean?.goodsId,
                          ),
                        ),

                        // ProductHtmlDescSectionView(
                        //     productDetailBean?.description),
                        SliverToBoxAdapter(
                          child: RecommendedProductSectionView(
                              recommendProductList),
                        ),
                      ],
                    )),
                bottomNavigationBar: ProductDeatilFooter(
                  productDetailBean,
                  callback: scrollToTop,
                ),
              ));
  }
}