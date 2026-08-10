.class Lorg/apache/cordova/inappbrowser/InAppBrowser$7;
.super Ljava/lang/Object;
.source "InAppBrowser.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lorg/apache/cordova/inappbrowser/InAppBrowser;->showWebPage(Ljava/lang/String;Ljava/util/HashMap;)Ljava/lang/String;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lorg/apache/cordova/inappbrowser/InAppBrowser;

.field final synthetic val$thatWebView:Lorg/apache/cordova/CordovaWebView;

.field final synthetic val$url:Ljava/lang/String;


# direct methods
.method constructor <init>(Lorg/apache/cordova/inappbrowser/InAppBrowser;Ljava/lang/String;Lorg/apache/cordova/CordovaWebView;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    iput-object p1, p0, Lorg/apache/cordova/inappbrowser/InAppBrowser$7;->this$0:Lorg/apache/cordova/inappbrowser/InAppBrowser;

    iput-object p2, p0, Lorg/apache/cordova/inappbrowser/InAppBrowser$7;->val$url:Ljava/lang/String;

    iput-object p3, p0, Lorg/apache/cordova/inappbrowser/InAppBrowser$7;->val$thatWebView:Lorg/apache/cordova/CordovaWebView;

    .line 718
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method private createCloseButton(I)Landroid/view/View;
    .locals 6

    iget-object v0, p0, Lorg/apache/cordova/inappbrowser/InAppBrowser$7;->this$0:Lorg/apache/cordova/inappbrowser/InAppBrowser;

    .line 735
    iget-object v0, v0, Lorg/apache/cordova/inappbrowser/InAppBrowser;->cordova:Lorg/apache/cordova/CordovaInterface;

    invoke-interface {v0}, Lorg/apache/cordova/CordovaInterface;->getActivity()Landroidx/appcompat/app/AppCompatActivity;

    move-result-object v0

    invoke-virtual {v0}, Landroidx/appcompat/app/AppCompatActivity;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    iget-object v1, p0, Lorg/apache/cordova/inappbrowser/InAppBrowser$7;->this$0:Lorg/apache/cordova/inappbrowser/InAppBrowser;

    .line 737
    invoke-static {v1}, Lorg/apache/cordova/inappbrowser/InAppBrowser;->-$$Nest$fgetcloseButtonCaption(Lorg/apache/cordova/inappbrowser/InAppBrowser;)Ljava/lang/String;

    move-result-object v1

    const-string v2, ""

    if-eq v1, v2, :cond_1

    .line 739
    new-instance v0, Landroid/widget/TextView;

    iget-object v1, p0, Lorg/apache/cordova/inappbrowser/InAppBrowser$7;->this$0:Lorg/apache/cordova/inappbrowser/InAppBrowser;

    iget-object v1, v1, Lorg/apache/cordova/inappbrowser/InAppBrowser;->cordova:Lorg/apache/cordova/CordovaInterface;

    invoke-interface {v1}, Lorg/apache/cordova/CordovaInterface;->getActivity()Landroidx/appcompat/app/AppCompatActivity;

    move-result-object v1

    invoke-direct {v0, v1}, Landroid/widget/TextView;-><init>(Landroid/content/Context;)V

    iget-object v1, p0, Lorg/apache/cordova/inappbrowser/InAppBrowser$7;->this$0:Lorg/apache/cordova/inappbrowser/InAppBrowser;

    .line 740
    invoke-static {v1}, Lorg/apache/cordova/inappbrowser/InAppBrowser;->-$$Nest$fgetcloseButtonCaption(Lorg/apache/cordova/inappbrowser/InAppBrowser;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    const/high16 v1, 0x41a00000    # 20.0f

    .line 741
    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setTextSize(F)V

    iget-object v1, p0, Lorg/apache/cordova/inappbrowser/InAppBrowser$7;->this$0:Lorg/apache/cordova/inappbrowser/InAppBrowser;

    .line 742
    invoke-static {v1}, Lorg/apache/cordova/inappbrowser/InAppBrowser;->-$$Nest$fgetcloseButtonColor(Lorg/apache/cordova/inappbrowser/InAppBrowser;)Ljava/lang/String;

    move-result-object v1

    if-eq v1, v2, :cond_0

    iget-object v1, p0, Lorg/apache/cordova/inappbrowser/InAppBrowser$7;->this$0:Lorg/apache/cordova/inappbrowser/InAppBrowser;

    invoke-static {v1}, Lorg/apache/cordova/inappbrowser/InAppBrowser;->-$$Nest$fgetcloseButtonColor(Lorg/apache/cordova/inappbrowser/InAppBrowser;)Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Landroid/graphics/Color;->parseColor(Ljava/lang/String;)I

    move-result v1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setTextColor(I)V

    :cond_0
    const/16 v1, 0x10

    .line 743
    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setGravity(I)V

    const/16 v1, 0xa

    .line 744
    invoke-direct {p0, v1}, Lorg/apache/cordova/inappbrowser/InAppBrowser$7;->dpToPixels(I)I

    move-result v2

    invoke-direct {p0, v1}, Lorg/apache/cordova/inappbrowser/InAppBrowser$7;->dpToPixels(I)I

    move-result v1

    const/4 v3, 0x0

    invoke-virtual {v0, v2, v3, v1, v3}, Landroid/widget/TextView;->setPadding(IIII)V

    goto :goto_0

    .line 748
    :cond_1
    new-instance v1, Landroid/widget/ImageButton;

    iget-object v3, p0, Lorg/apache/cordova/inappbrowser/InAppBrowser$7;->this$0:Lorg/apache/cordova/inappbrowser/InAppBrowser;

    iget-object v3, v3, Lorg/apache/cordova/inappbrowser/InAppBrowser;->cordova:Lorg/apache/cordova/CordovaInterface;

    invoke-interface {v3}, Lorg/apache/cordova/CordovaInterface;->getActivity()Landroidx/appcompat/app/AppCompatActivity;

    move-result-object v3

    invoke-direct {v1, v3}, Landroid/widget/ImageButton;-><init>(Landroid/content/Context;)V

    iget-object v3, p0, Lorg/apache/cordova/inappbrowser/InAppBrowser$7;->this$0:Lorg/apache/cordova/inappbrowser/InAppBrowser;

    .line 749
    iget-object v3, v3, Lorg/apache/cordova/inappbrowser/InAppBrowser;->cordova:Lorg/apache/cordova/CordovaInterface;

    invoke-interface {v3}, Lorg/apache/cordova/CordovaInterface;->getActivity()Landroidx/appcompat/app/AppCompatActivity;

    move-result-object v3

    invoke-virtual {v3}, Landroidx/appcompat/app/AppCompatActivity;->getPackageName()Ljava/lang/String;

    move-result-object v3

    const-string v4, "ic_action_remove"

    const-string v5, "drawable"

    invoke-virtual {v0, v4, v5, v3}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v3

    .line 750
    invoke-virtual {v0, v3}, Landroid/content/res/Resources;->getDrawable(I)Landroid/graphics/drawable/Drawable;

    move-result-object v0

    iget-object v3, p0, Lorg/apache/cordova/inappbrowser/InAppBrowser$7;->this$0:Lorg/apache/cordova/inappbrowser/InAppBrowser;

    .line 751
    invoke-static {v3}, Lorg/apache/cordova/inappbrowser/InAppBrowser;->-$$Nest$fgetcloseButtonColor(Lorg/apache/cordova/inappbrowser/InAppBrowser;)Ljava/lang/String;

    move-result-object v3

    if-eq v3, v2, :cond_2

    iget-object v2, p0, Lorg/apache/cordova/inappbrowser/InAppBrowser$7;->this$0:Lorg/apache/cordova/inappbrowser/InAppBrowser;

    invoke-static {v2}, Lorg/apache/cordova/inappbrowser/InAppBrowser;->-$$Nest$fgetcloseButtonColor(Lorg/apache/cordova/inappbrowser/InAppBrowser;)Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Landroid/graphics/Color;->parseColor(Ljava/lang/String;)I

    move-result v2

    invoke-virtual {v1, v2}, Landroid/widget/ImageButton;->setColorFilter(I)V

    .line 752
    :cond_2
    invoke-virtual {v1, v0}, Landroid/widget/ImageButton;->setImageDrawable(Landroid/graphics/drawable/Drawable;)V

    .line 753
    sget-object v0, Landroid/widget/ImageView$ScaleType;->FIT_CENTER:Landroid/widget/ImageView$ScaleType;

    invoke-virtual {v1, v0}, Landroid/widget/ImageButton;->setScaleType(Landroid/widget/ImageView$ScaleType;)V

    .line 754
    invoke-virtual {v1}, Landroid/widget/ImageButton;->getAdjustViewBounds()Z

    move-object v0, v1

    .line 759
    :goto_0
    new-instance v1, Landroid/widget/RelativeLayout$LayoutParams;

    const/4 v2, -0x2

    const/4 v3, -0x1

    invoke-direct {v1, v2, v3}, Landroid/widget/RelativeLayout$LayoutParams;-><init>(II)V

    iget-object v2, p0, Lorg/apache/cordova/inappbrowser/InAppBrowser$7;->this$0:Lorg/apache/cordova/inappbrowser/InAppBrowser;

    .line 760
    invoke-static {v2}, Lorg/apache/cordova/inappbrowser/InAppBrowser;->-$$Nest$fgetleftToRight(Lorg/apache/cordova/inappbrowser/InAppBrowser;)Z

    move-result v2

    if-eqz v2, :cond_3

    const/16 v2, 0x9

    invoke-virtual {v1, v2}, Landroid/widget/RelativeLayout$LayoutParams;->addRule(I)V

    goto :goto_1

    :cond_3
    const/16 v2, 0xb

    .line 761
    invoke-virtual {v1, v2}, Landroid/widget/RelativeLayout$LayoutParams;->addRule(I)V

    .line 762
    :goto_1
    invoke-virtual {v0, v1}, Landroid/view/View;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    const/4 v1, 0x0

    .line 763
    invoke-virtual {v0, v1}, Landroid/view/View;->setBackground(Landroid/graphics/drawable/Drawable;)V

    const-string v1, "Close Button"

    .line 765
    invoke-virtual {v0, v1}, Landroid/view/View;->setContentDescription(Ljava/lang/CharSequence;)V

    .line 766
    invoke-static {p1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/Integer;->intValue()I

    move-result p1

    invoke-virtual {v0, p1}, Landroid/view/View;->setId(I)V

    .line 767
    new-instance p1, Lorg/apache/cordova/inappbrowser/InAppBrowser$7$1;

    invoke-direct {p1, p0}, Lorg/apache/cordova/inappbrowser/InAppBrowser$7$1;-><init>(Lorg/apache/cordova/inappbrowser/InAppBrowser$7;)V

    invoke-virtual {v0, p1}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    return-object v0
.end method

.method private dpToPixels(I)I
    .locals 2

    int-to-float p1, p1

    iget-object v0, p0, Lorg/apache/cordova/inappbrowser/InAppBrowser$7;->this$0:Lorg/apache/cordova/inappbrowser/InAppBrowser;

    .line 725
    iget-object v0, v0, Lorg/apache/cordova/inappbrowser/InAppBrowser;->cordova:Lorg/apache/cordova/CordovaInterface;

    .line 727
    invoke-interface {v0}, Lorg/apache/cordova/CordovaInterface;->getActivity()Landroidx/appcompat/app/AppCompatActivity;

    move-result-object v0

    invoke-virtual {v0}, Landroidx/appcompat/app/AppCompatActivity;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    invoke-virtual {v0}, Landroid/content/res/Resources;->getDisplayMetrics()Landroid/util/DisplayMetrics;

    move-result-object v0

    const/4 v1, 0x1

    .line 725
    invoke-static {v1, p1, v0}, Landroid/util/TypedValue;->applyDimension(IFLandroid/util/DisplayMetrics;)F

    move-result p1

    float-to-int p1, p1

    return p1
.end method


# virtual methods
.method public run()V
    .locals 16

    move-object/from16 v0, p0

    iget-object v1, v0, Lorg/apache/cordova/inappbrowser/InAppBrowser$7;->this$0:Lorg/apache/cordova/inappbrowser/InAppBrowser;

    .line 780
    invoke-static {v1}, Lorg/apache/cordova/inappbrowser/InAppBrowser;->-$$Nest$fgetdialog(Lorg/apache/cordova/inappbrowser/InAppBrowser;)Lorg/apache/cordova/inappbrowser/InAppBrowserDialog;

    move-result-object v1

    if-eqz v1, :cond_0

    iget-object v1, v0, Lorg/apache/cordova/inappbrowser/InAppBrowser$7;->this$0:Lorg/apache/cordova/inappbrowser/InAppBrowser;

    .line 781
    invoke-static {v1}, Lorg/apache/cordova/inappbrowser/InAppBrowser;->-$$Nest$fgetdialog(Lorg/apache/cordova/inappbrowser/InAppBrowser;)Lorg/apache/cordova/inappbrowser/InAppBrowserDialog;

    move-result-object v1

    invoke-virtual {v1}, Lorg/apache/cordova/inappbrowser/InAppBrowserDialog;->dismiss()V

    :cond_0
    iget-object v1, v0, Lorg/apache/cordova/inappbrowser/InAppBrowser$7;->this$0:Lorg/apache/cordova/inappbrowser/InAppBrowser;

    .line 785
    new-instance v2, Lorg/apache/cordova/inappbrowser/InAppBrowserDialog;

    iget-object v3, v0, Lorg/apache/cordova/inappbrowser/InAppBrowser$7;->this$0:Lorg/apache/cordova/inappbrowser/InAppBrowser;

    iget-object v3, v3, Lorg/apache/cordova/inappbrowser/InAppBrowser;->cordova:Lorg/apache/cordova/CordovaInterface;

    invoke-interface {v3}, Lorg/apache/cordova/CordovaInterface;->getActivity()Landroidx/appcompat/app/AppCompatActivity;

    move-result-object v3

    const v4, 0x1030006

    invoke-direct {v2, v3, v4}, Lorg/apache/cordova/inappbrowser/InAppBrowserDialog;-><init>(Landroid/content/Context;I)V

    invoke-static {v1, v2}, Lorg/apache/cordova/inappbrowser/InAppBrowser;->-$$Nest$fputdialog(Lorg/apache/cordova/inappbrowser/InAppBrowser;Lorg/apache/cordova/inappbrowser/InAppBrowserDialog;)V

    iget-object v1, v0, Lorg/apache/cordova/inappbrowser/InAppBrowser$7;->this$0:Lorg/apache/cordova/inappbrowser/InAppBrowser;

    .line 786
    invoke-static {v1}, Lorg/apache/cordova/inappbrowser/InAppBrowser;->-$$Nest$fgetdialog(Lorg/apache/cordova/inappbrowser/InAppBrowser;)Lorg/apache/cordova/inappbrowser/InAppBrowserDialog;

    move-result-object v1

    invoke-virtual {v1}, Lorg/apache/cordova/inappbrowser/InAppBrowserDialog;->getWindow()Landroid/view/Window;

    move-result-object v1

    invoke-virtual {v1}, Landroid/view/Window;->getAttributes()Landroid/view/WindowManager$LayoutParams;

    move-result-object v1

    const v2, 0x1030002

    iput v2, v1, Landroid/view/WindowManager$LayoutParams;->windowAnimations:I

    iget-object v1, v0, Lorg/apache/cordova/inappbrowser/InAppBrowser$7;->this$0:Lorg/apache/cordova/inappbrowser/InAppBrowser;

    .line 787
    invoke-static {v1}, Lorg/apache/cordova/inappbrowser/InAppBrowser;->-$$Nest$fgetdialog(Lorg/apache/cordova/inappbrowser/InAppBrowser;)Lorg/apache/cordova/inappbrowser/InAppBrowserDialog;

    move-result-object v1

    const/4 v2, 0x1

    invoke-virtual {v1, v2}, Lorg/apache/cordova/inappbrowser/InAppBrowserDialog;->requestWindowFeature(I)Z

    iget-object v1, v0, Lorg/apache/cordova/inappbrowser/InAppBrowser$7;->this$0:Lorg/apache/cordova/inappbrowser/InAppBrowser;

    .line 788
    invoke-static {v1}, Lorg/apache/cordova/inappbrowser/InAppBrowser;->-$$Nest$fgetfullscreen(Lorg/apache/cordova/inappbrowser/InAppBrowser;)Z

    move-result v1

    if-eqz v1, :cond_1

    iget-object v1, v0, Lorg/apache/cordova/inappbrowser/InAppBrowser$7;->this$0:Lorg/apache/cordova/inappbrowser/InAppBrowser;

    .line 789
    invoke-static {v1}, Lorg/apache/cordova/inappbrowser/InAppBrowser;->-$$Nest$fgetdialog(Lorg/apache/cordova/inappbrowser/InAppBrowser;)Lorg/apache/cordova/inappbrowser/InAppBrowserDialog;

    move-result-object v1

    invoke-virtual {v1}, Lorg/apache/cordova/inappbrowser/InAppBrowserDialog;->getWindow()Landroid/view/Window;

    move-result-object v1

    const/16 v3, 0x400

    invoke-virtual {v1, v3, v3}, Landroid/view/Window;->setFlags(II)V

    :cond_1
    iget-object v1, v0, Lorg/apache/cordova/inappbrowser/InAppBrowser$7;->this$0:Lorg/apache/cordova/inappbrowser/InAppBrowser;

    .line 791
    invoke-static {v1}, Lorg/apache/cordova/inappbrowser/InAppBrowser;->-$$Nest$fgetdialog(Lorg/apache/cordova/inappbrowser/InAppBrowser;)Lorg/apache/cordova/inappbrowser/InAppBrowserDialog;

    move-result-object v1

    invoke-virtual {v1, v2}, Lorg/apache/cordova/inappbrowser/InAppBrowserDialog;->setCancelable(Z)V

    iget-object v1, v0, Lorg/apache/cordova/inappbrowser/InAppBrowser$7;->this$0:Lorg/apache/cordova/inappbrowser/InAppBrowser;

    .line 792
    invoke-static {v1}, Lorg/apache/cordova/inappbrowser/InAppBrowser;->-$$Nest$fgetdialog(Lorg/apache/cordova/inappbrowser/InAppBrowser;)Lorg/apache/cordova/inappbrowser/InAppBrowserDialog;

    move-result-object v1

    iget-object v3, v0, Lorg/apache/cordova/inappbrowser/InAppBrowser$7;->this$0:Lorg/apache/cordova/inappbrowser/InAppBrowser;

    invoke-static {v3}, Lorg/apache/cordova/inappbrowser/InAppBrowser;->-$$Nest$mgetInAppBrowser(Lorg/apache/cordova/inappbrowser/InAppBrowser;)Lorg/apache/cordova/inappbrowser/InAppBrowser;

    move-result-object v3

    invoke-virtual {v1, v3}, Lorg/apache/cordova/inappbrowser/InAppBrowserDialog;->setInAppBroswer(Lorg/apache/cordova/inappbrowser/InAppBrowser;)V

    .line 795
    new-instance v1, Landroid/widget/LinearLayout;

    iget-object v3, v0, Lorg/apache/cordova/inappbrowser/InAppBrowser$7;->this$0:Lorg/apache/cordova/inappbrowser/InAppBrowser;

    iget-object v3, v3, Lorg/apache/cordova/inappbrowser/InAppBrowser;->cordova:Lorg/apache/cordova/CordovaInterface;

    invoke-interface {v3}, Lorg/apache/cordova/CordovaInterface;->getActivity()Landroidx/appcompat/app/AppCompatActivity;

    move-result-object v3

    invoke-direct {v1, v3}, Landroid/widget/LinearLayout;-><init>(Landroid/content/Context;)V

    .line 796
    invoke-virtual {v1, v2}, Landroid/widget/LinearLayout;->setOrientation(I)V

    .line 799
    new-instance v3, Landroid/widget/RelativeLayout;

    iget-object v4, v0, Lorg/apache/cordova/inappbrowser/InAppBrowser$7;->this$0:Lorg/apache/cordova/inappbrowser/InAppBrowser;

    iget-object v4, v4, Lorg/apache/cordova/inappbrowser/InAppBrowser;->cordova:Lorg/apache/cordova/CordovaInterface;

    invoke-interface {v4}, Lorg/apache/cordova/CordovaInterface;->getActivity()Landroidx/appcompat/app/AppCompatActivity;

    move-result-object v4

    invoke-direct {v3, v4}, Landroid/widget/RelativeLayout;-><init>(Landroid/content/Context;)V

    iget-object v4, v0, Lorg/apache/cordova/inappbrowser/InAppBrowser$7;->this$0:Lorg/apache/cordova/inappbrowser/InAppBrowser;

    .line 801
    invoke-static {v4}, Lorg/apache/cordova/inappbrowser/InAppBrowser;->-$$Nest$fgettoolbarColor(Lorg/apache/cordova/inappbrowser/InAppBrowser;)I

    move-result v4

    invoke-virtual {v3, v4}, Landroid/widget/RelativeLayout;->setBackgroundColor(I)V

    .line 802
    new-instance v4, Landroid/widget/RelativeLayout$LayoutParams;

    const/16 v5, 0x2c

    invoke-direct {v0, v5}, Lorg/apache/cordova/inappbrowser/InAppBrowser$7;->dpToPixels(I)I

    move-result v6

    const/4 v7, -0x1

    invoke-direct {v4, v7, v6}, Landroid/widget/RelativeLayout$LayoutParams;-><init>(II)V

    invoke-virtual {v3, v4}, Landroid/widget/RelativeLayout;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    const/4 v4, 0x2

    .line 803
    invoke-direct {v0, v4}, Lorg/apache/cordova/inappbrowser/InAppBrowser$7;->dpToPixels(I)I

    move-result v6

    invoke-direct {v0, v4}, Lorg/apache/cordova/inappbrowser/InAppBrowser$7;->dpToPixels(I)I

    move-result v8

    invoke-direct {v0, v4}, Lorg/apache/cordova/inappbrowser/InAppBrowser$7;->dpToPixels(I)I

    move-result v9

    invoke-direct {v0, v4}, Lorg/apache/cordova/inappbrowser/InAppBrowser$7;->dpToPixels(I)I

    move-result v10

    invoke-virtual {v3, v6, v8, v9, v10}, Landroid/widget/RelativeLayout;->setPadding(IIII)V

    iget-object v6, v0, Lorg/apache/cordova/inappbrowser/InAppBrowser$7;->this$0:Lorg/apache/cordova/inappbrowser/InAppBrowser;

    .line 804
    invoke-static {v6}, Lorg/apache/cordova/inappbrowser/InAppBrowser;->-$$Nest$fgetleftToRight(Lorg/apache/cordova/inappbrowser/InAppBrowser;)Z

    move-result v6

    const/4 v8, 0x3

    const/4 v9, 0x5

    if-eqz v6, :cond_2

    .line 805
    invoke-virtual {v3, v8}, Landroid/widget/RelativeLayout;->setHorizontalGravity(I)V

    goto :goto_0

    .line 807
    :cond_2
    invoke-virtual {v3, v9}, Landroid/widget/RelativeLayout;->setHorizontalGravity(I)V

    :goto_0
    const/16 v6, 0x30

    .line 809
    invoke-virtual {v3, v6}, Landroid/widget/RelativeLayout;->setVerticalGravity(I)V

    .line 812
    new-instance v6, Landroid/widget/RelativeLayout;

    iget-object v10, v0, Lorg/apache/cordova/inappbrowser/InAppBrowser$7;->this$0:Lorg/apache/cordova/inappbrowser/InAppBrowser;

    iget-object v10, v10, Lorg/apache/cordova/inappbrowser/InAppBrowser;->cordova:Lorg/apache/cordova/CordovaInterface;

    invoke-interface {v10}, Lorg/apache/cordova/CordovaInterface;->getActivity()Landroidx/appcompat/app/AppCompatActivity;

    move-result-object v10

    invoke-direct {v6, v10}, Landroid/widget/RelativeLayout;-><init>(Landroid/content/Context;)V

    .line 813
    new-instance v10, Landroid/widget/RelativeLayout$LayoutParams;

    const/4 v11, -0x2

    invoke-direct {v10, v11, v11}, Landroid/widget/RelativeLayout$LayoutParams;-><init>(II)V

    iget-object v12, v0, Lorg/apache/cordova/inappbrowser/InAppBrowser$7;->this$0:Lorg/apache/cordova/inappbrowser/InAppBrowser;

    .line 814
    invoke-static {v12}, Lorg/apache/cordova/inappbrowser/InAppBrowser;->-$$Nest$fgetleftToRight(Lorg/apache/cordova/inappbrowser/InAppBrowser;)Z

    move-result v12

    if-eqz v12, :cond_3

    const/16 v12, 0xb

    invoke-virtual {v10, v12}, Landroid/widget/RelativeLayout$LayoutParams;->addRule(I)V

    goto :goto_1

    :cond_3
    const/16 v12, 0x9

    .line 815
    invoke-virtual {v10, v12}, Landroid/widget/RelativeLayout$LayoutParams;->addRule(I)V

    .line 816
    :goto_1
    invoke-virtual {v6, v10}, Landroid/widget/RelativeLayout;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 817
    invoke-virtual {v6, v8}, Landroid/widget/RelativeLayout;->setHorizontalGravity(I)V

    const/16 v10, 0x10

    .line 818
    invoke-virtual {v6, v10}, Landroid/widget/RelativeLayout;->setVerticalGravity(I)V

    iget-object v12, v0, Lorg/apache/cordova/inappbrowser/InAppBrowser$7;->this$0:Lorg/apache/cordova/inappbrowser/InAppBrowser;

    .line 819
    invoke-static {v12}, Lorg/apache/cordova/inappbrowser/InAppBrowser;->-$$Nest$fgetleftToRight(Lorg/apache/cordova/inappbrowser/InAppBrowser;)Z

    move-result v12

    if-eqz v12, :cond_4

    invoke-static {v9}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v12

    goto :goto_2

    :cond_4
    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v12

    :goto_2
    invoke-virtual {v12}, Ljava/lang/Integer;->intValue()I

    move-result v12

    invoke-virtual {v6, v12}, Landroid/widget/RelativeLayout;->setId(I)V

    .line 822
    new-instance v12, Landroid/widget/ImageButton;

    iget-object v13, v0, Lorg/apache/cordova/inappbrowser/InAppBrowser$7;->this$0:Lorg/apache/cordova/inappbrowser/InAppBrowser;

    iget-object v13, v13, Lorg/apache/cordova/inappbrowser/InAppBrowser;->cordova:Lorg/apache/cordova/CordovaInterface;

    invoke-interface {v13}, Lorg/apache/cordova/CordovaInterface;->getActivity()Landroidx/appcompat/app/AppCompatActivity;

    move-result-object v13

    invoke-direct {v12, v13}, Landroid/widget/ImageButton;-><init>(Landroid/content/Context;)V

    .line 823
    new-instance v13, Landroid/widget/RelativeLayout$LayoutParams;

    invoke-direct {v13, v11, v7}, Landroid/widget/RelativeLayout$LayoutParams;-><init>(II)V

    .line 824
    invoke-virtual {v13, v9}, Landroid/widget/RelativeLayout$LayoutParams;->addRule(I)V

    .line 825
    invoke-virtual {v12, v13}, Landroid/widget/ImageButton;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    const-string v13, "Back Button"

    .line 826
    invoke-virtual {v12, v13}, Landroid/widget/ImageButton;->setContentDescription(Ljava/lang/CharSequence;)V

    .line 827
    invoke-static {v4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v13

    invoke-virtual {v13}, Ljava/lang/Integer;->intValue()I

    move-result v13

    invoke-virtual {v12, v13}, Landroid/widget/ImageButton;->setId(I)V

    iget-object v13, v0, Lorg/apache/cordova/inappbrowser/InAppBrowser$7;->this$0:Lorg/apache/cordova/inappbrowser/InAppBrowser;

    .line 828
    iget-object v13, v13, Lorg/apache/cordova/inappbrowser/InAppBrowser;->cordova:Lorg/apache/cordova/CordovaInterface;

    invoke-interface {v13}, Lorg/apache/cordova/CordovaInterface;->getActivity()Landroidx/appcompat/app/AppCompatActivity;

    move-result-object v13

    invoke-virtual {v13}, Landroidx/appcompat/app/AppCompatActivity;->getResources()Landroid/content/res/Resources;

    move-result-object v13

    iget-object v14, v0, Lorg/apache/cordova/inappbrowser/InAppBrowser$7;->this$0:Lorg/apache/cordova/inappbrowser/InAppBrowser;

    .line 829
    iget-object v14, v14, Lorg/apache/cordova/inappbrowser/InAppBrowser;->cordova:Lorg/apache/cordova/CordovaInterface;

    invoke-interface {v14}, Lorg/apache/cordova/CordovaInterface;->getActivity()Landroidx/appcompat/app/AppCompatActivity;

    move-result-object v14

    invoke-virtual {v14}, Landroidx/appcompat/app/AppCompatActivity;->getPackageName()Ljava/lang/String;

    move-result-object v14

    const-string v15, "ic_action_previous_item"

    const-string v5, "drawable"

    invoke-virtual {v13, v15, v5, v14}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v14

    .line 830
    invoke-virtual {v13, v14}, Landroid/content/res/Resources;->getDrawable(I)Landroid/graphics/drawable/Drawable;

    move-result-object v14

    iget-object v15, v0, Lorg/apache/cordova/inappbrowser/InAppBrowser$7;->this$0:Lorg/apache/cordova/inappbrowser/InAppBrowser;

    .line 831
    invoke-static {v15}, Lorg/apache/cordova/inappbrowser/InAppBrowser;->-$$Nest$fgetnavigationButtonColor(Lorg/apache/cordova/inappbrowser/InAppBrowser;)Ljava/lang/String;

    move-result-object v15

    const-string v10, ""

    if-eq v15, v10, :cond_5

    iget-object v15, v0, Lorg/apache/cordova/inappbrowser/InAppBrowser$7;->this$0:Lorg/apache/cordova/inappbrowser/InAppBrowser;

    invoke-static {v15}, Lorg/apache/cordova/inappbrowser/InAppBrowser;->-$$Nest$fgetnavigationButtonColor(Lorg/apache/cordova/inappbrowser/InAppBrowser;)Ljava/lang/String;

    move-result-object v15

    invoke-static {v15}, Landroid/graphics/Color;->parseColor(Ljava/lang/String;)I

    move-result v15

    invoke-virtual {v12, v15}, Landroid/widget/ImageButton;->setColorFilter(I)V

    :cond_5
    const/4 v15, 0x0

    .line 832
    invoke-virtual {v12, v15}, Landroid/widget/ImageButton;->setBackground(Landroid/graphics/drawable/Drawable;)V

    .line 833
    invoke-virtual {v12, v14}, Landroid/widget/ImageButton;->setImageDrawable(Landroid/graphics/drawable/Drawable;)V

    .line 834
    sget-object v14, Landroid/widget/ImageView$ScaleType;->FIT_CENTER:Landroid/widget/ImageView$ScaleType;

    invoke-virtual {v12, v14}, Landroid/widget/ImageButton;->setScaleType(Landroid/widget/ImageView$ScaleType;)V

    const/16 v14, 0xa

    .line 835
    invoke-direct {v0, v14}, Lorg/apache/cordova/inappbrowser/InAppBrowser$7;->dpToPixels(I)I

    move-result v9

    invoke-direct {v0, v14}, Lorg/apache/cordova/inappbrowser/InAppBrowser$7;->dpToPixels(I)I

    move-result v15

    const/4 v14, 0x0

    invoke-virtual {v12, v14, v9, v14, v15}, Landroid/widget/ImageButton;->setPadding(IIII)V

    .line 836
    invoke-virtual {v12}, Landroid/widget/ImageButton;->getAdjustViewBounds()Z

    .line 838
    new-instance v9, Lorg/apache/cordova/inappbrowser/InAppBrowser$7$2;

    invoke-direct {v9, v0}, Lorg/apache/cordova/inappbrowser/InAppBrowser$7$2;-><init>(Lorg/apache/cordova/inappbrowser/InAppBrowser$7;)V

    invoke-virtual {v12, v9}, Landroid/widget/ImageButton;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 845
    new-instance v9, Landroid/widget/ImageButton;

    iget-object v15, v0, Lorg/apache/cordova/inappbrowser/InAppBrowser$7;->this$0:Lorg/apache/cordova/inappbrowser/InAppBrowser;

    iget-object v15, v15, Lorg/apache/cordova/inappbrowser/InAppBrowser;->cordova:Lorg/apache/cordova/CordovaInterface;

    invoke-interface {v15}, Lorg/apache/cordova/CordovaInterface;->getActivity()Landroidx/appcompat/app/AppCompatActivity;

    move-result-object v15

    invoke-direct {v9, v15}, Landroid/widget/ImageButton;-><init>(Landroid/content/Context;)V

    .line 846
    new-instance v15, Landroid/widget/RelativeLayout$LayoutParams;

    invoke-direct {v15, v11, v7}, Landroid/widget/RelativeLayout$LayoutParams;-><init>(II)V

    .line 847
    invoke-virtual {v15, v2, v4}, Landroid/widget/RelativeLayout$LayoutParams;->addRule(II)V

    .line 848
    invoke-virtual {v9, v15}, Landroid/widget/ImageButton;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    const-string v11, "Forward Button"

    .line 849
    invoke-virtual {v9, v11}, Landroid/widget/ImageButton;->setContentDescription(Ljava/lang/CharSequence;)V

    .line 850
    invoke-static {v8}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v11

    invoke-virtual {v11}, Ljava/lang/Integer;->intValue()I

    move-result v11

    invoke-virtual {v9, v11}, Landroid/widget/ImageButton;->setId(I)V

    iget-object v11, v0, Lorg/apache/cordova/inappbrowser/InAppBrowser$7;->this$0:Lorg/apache/cordova/inappbrowser/InAppBrowser;

    .line 851
    iget-object v11, v11, Lorg/apache/cordova/inappbrowser/InAppBrowser;->cordova:Lorg/apache/cordova/CordovaInterface;

    invoke-interface {v11}, Lorg/apache/cordova/CordovaInterface;->getActivity()Landroidx/appcompat/app/AppCompatActivity;

    move-result-object v11

    invoke-virtual {v11}, Landroidx/appcompat/app/AppCompatActivity;->getPackageName()Ljava/lang/String;

    move-result-object v11

    const-string v15, "ic_action_next_item"

    invoke-virtual {v13, v15, v5, v11}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v5

    .line 852
    invoke-virtual {v13, v5}, Landroid/content/res/Resources;->getDrawable(I)Landroid/graphics/drawable/Drawable;

    move-result-object v5

    iget-object v11, v0, Lorg/apache/cordova/inappbrowser/InAppBrowser$7;->this$0:Lorg/apache/cordova/inappbrowser/InAppBrowser;

    .line 853
    invoke-static {v11}, Lorg/apache/cordova/inappbrowser/InAppBrowser;->-$$Nest$fgetnavigationButtonColor(Lorg/apache/cordova/inappbrowser/InAppBrowser;)Ljava/lang/String;

    move-result-object v11

    if-eq v11, v10, :cond_6

    iget-object v11, v0, Lorg/apache/cordova/inappbrowser/InAppBrowser$7;->this$0:Lorg/apache/cordova/inappbrowser/InAppBrowser;

    invoke-static {v11}, Lorg/apache/cordova/inappbrowser/InAppBrowser;->-$$Nest$fgetnavigationButtonColor(Lorg/apache/cordova/inappbrowser/InAppBrowser;)Ljava/lang/String;

    move-result-object v11

    invoke-static {v11}, Landroid/graphics/Color;->parseColor(Ljava/lang/String;)I

    move-result v11

    invoke-virtual {v9, v11}, Landroid/widget/ImageButton;->setColorFilter(I)V

    :cond_6
    const/4 v11, 0x0

    .line 854
    invoke-virtual {v9, v11}, Landroid/widget/ImageButton;->setBackground(Landroid/graphics/drawable/Drawable;)V

    .line 855
    invoke-virtual {v9, v5}, Landroid/widget/ImageButton;->setImageDrawable(Landroid/graphics/drawable/Drawable;)V

    .line 856
    sget-object v5, Landroid/widget/ImageView$ScaleType;->FIT_CENTER:Landroid/widget/ImageView$ScaleType;

    invoke-virtual {v9, v5}, Landroid/widget/ImageButton;->setScaleType(Landroid/widget/ImageView$ScaleType;)V

    const/16 v5, 0xa

    .line 857
    invoke-direct {v0, v5}, Lorg/apache/cordova/inappbrowser/InAppBrowser$7;->dpToPixels(I)I

    move-result v11

    invoke-direct {v0, v5}, Lorg/apache/cordova/inappbrowser/InAppBrowser$7;->dpToPixels(I)I

    move-result v5

    invoke-virtual {v9, v14, v11, v14, v5}, Landroid/widget/ImageButton;->setPadding(IIII)V

    .line 858
    invoke-virtual {v9}, Landroid/widget/ImageButton;->getAdjustViewBounds()Z

    .line 860
    new-instance v5, Lorg/apache/cordova/inappbrowser/InAppBrowser$7$3;

    invoke-direct {v5, v0}, Lorg/apache/cordova/inappbrowser/InAppBrowser$7$3;-><init>(Lorg/apache/cordova/inappbrowser/InAppBrowser$7;)V

    invoke-virtual {v9, v5}, Landroid/widget/ImageButton;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    iget-object v5, v0, Lorg/apache/cordova/inappbrowser/InAppBrowser$7;->this$0:Lorg/apache/cordova/inappbrowser/InAppBrowser;

    .line 867
    new-instance v11, Landroid/widget/EditText;

    iget-object v13, v0, Lorg/apache/cordova/inappbrowser/InAppBrowser$7;->this$0:Lorg/apache/cordova/inappbrowser/InAppBrowser;

    iget-object v13, v13, Lorg/apache/cordova/inappbrowser/InAppBrowser;->cordova:Lorg/apache/cordova/CordovaInterface;

    invoke-interface {v13}, Lorg/apache/cordova/CordovaInterface;->getActivity()Landroidx/appcompat/app/AppCompatActivity;

    move-result-object v13

    invoke-direct {v11, v13}, Landroid/widget/EditText;-><init>(Landroid/content/Context;)V

    invoke-static {v5, v11}, Lorg/apache/cordova/inappbrowser/InAppBrowser;->-$$Nest$fputedittext(Lorg/apache/cordova/inappbrowser/InAppBrowser;Landroid/widget/EditText;)V

    .line 868
    new-instance v5, Landroid/widget/RelativeLayout$LayoutParams;

    invoke-direct {v5, v7, v7}, Landroid/widget/RelativeLayout$LayoutParams;-><init>(II)V

    .line 869
    invoke-virtual {v5, v2, v2}, Landroid/widget/RelativeLayout$LayoutParams;->addRule(II)V

    const/4 v11, 0x5

    .line 870
    invoke-virtual {v5, v14, v11}, Landroid/widget/RelativeLayout$LayoutParams;->addRule(II)V

    iget-object v13, v0, Lorg/apache/cordova/inappbrowser/InAppBrowser$7;->this$0:Lorg/apache/cordova/inappbrowser/InAppBrowser;

    .line 871
    invoke-static {v13}, Lorg/apache/cordova/inappbrowser/InAppBrowser;->-$$Nest$fgetedittext(Lorg/apache/cordova/inappbrowser/InAppBrowser;)Landroid/widget/EditText;

    move-result-object v13

    invoke-virtual {v13, v5}, Landroid/widget/EditText;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    iget-object v5, v0, Lorg/apache/cordova/inappbrowser/InAppBrowser$7;->this$0:Lorg/apache/cordova/inappbrowser/InAppBrowser;

    .line 872
    invoke-static {v5}, Lorg/apache/cordova/inappbrowser/InAppBrowser;->-$$Nest$fgetedittext(Lorg/apache/cordova/inappbrowser/InAppBrowser;)Landroid/widget/EditText;

    move-result-object v5

    const/4 v13, 0x4

    invoke-static {v13}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v13

    invoke-virtual {v13}, Ljava/lang/Integer;->intValue()I

    move-result v13

    invoke-virtual {v5, v13}, Landroid/widget/EditText;->setId(I)V

    iget-object v5, v0, Lorg/apache/cordova/inappbrowser/InAppBrowser$7;->this$0:Lorg/apache/cordova/inappbrowser/InAppBrowser;

    .line 873
    invoke-static {v5}, Lorg/apache/cordova/inappbrowser/InAppBrowser;->-$$Nest$fgetedittext(Lorg/apache/cordova/inappbrowser/InAppBrowser;)Landroid/widget/EditText;

    move-result-object v5

    invoke-virtual {v5, v2}, Landroid/widget/EditText;->setSingleLine(Z)V

    iget-object v5, v0, Lorg/apache/cordova/inappbrowser/InAppBrowser$7;->this$0:Lorg/apache/cordova/inappbrowser/InAppBrowser;

    .line 874
    invoke-static {v5}, Lorg/apache/cordova/inappbrowser/InAppBrowser;->-$$Nest$fgetedittext(Lorg/apache/cordova/inappbrowser/InAppBrowser;)Landroid/widget/EditText;

    move-result-object v5

    iget-object v13, v0, Lorg/apache/cordova/inappbrowser/InAppBrowser$7;->val$url:Ljava/lang/String;

    invoke-virtual {v5, v13}, Landroid/widget/EditText;->setText(Ljava/lang/CharSequence;)V

    iget-object v5, v0, Lorg/apache/cordova/inappbrowser/InAppBrowser$7;->this$0:Lorg/apache/cordova/inappbrowser/InAppBrowser;

    .line 875
    invoke-static {v5}, Lorg/apache/cordova/inappbrowser/InAppBrowser;->-$$Nest$fgetedittext(Lorg/apache/cordova/inappbrowser/InAppBrowser;)Landroid/widget/EditText;

    move-result-object v5

    const/16 v13, 0x10

    invoke-virtual {v5, v13}, Landroid/widget/EditText;->setInputType(I)V

    iget-object v5, v0, Lorg/apache/cordova/inappbrowser/InAppBrowser$7;->this$0:Lorg/apache/cordova/inappbrowser/InAppBrowser;

    .line 876
    invoke-static {v5}, Lorg/apache/cordova/inappbrowser/InAppBrowser;->-$$Nest$fgetedittext(Lorg/apache/cordova/inappbrowser/InAppBrowser;)Landroid/widget/EditText;

    move-result-object v5

    invoke-virtual {v5, v4}, Landroid/widget/EditText;->setImeOptions(I)V

    iget-object v4, v0, Lorg/apache/cordova/inappbrowser/InAppBrowser$7;->this$0:Lorg/apache/cordova/inappbrowser/InAppBrowser;

    .line 877
    invoke-static {v4}, Lorg/apache/cordova/inappbrowser/InAppBrowser;->-$$Nest$fgetedittext(Lorg/apache/cordova/inappbrowser/InAppBrowser;)Landroid/widget/EditText;

    move-result-object v4

    invoke-virtual {v4, v14}, Landroid/widget/EditText;->setInputType(I)V

    iget-object v4, v0, Lorg/apache/cordova/inappbrowser/InAppBrowser$7;->this$0:Lorg/apache/cordova/inappbrowser/InAppBrowser;

    .line 878
    invoke-static {v4}, Lorg/apache/cordova/inappbrowser/InAppBrowser;->-$$Nest$fgetedittext(Lorg/apache/cordova/inappbrowser/InAppBrowser;)Landroid/widget/EditText;

    move-result-object v4

    new-instance v5, Lorg/apache/cordova/inappbrowser/InAppBrowser$7$4;

    invoke-direct {v5, v0}, Lorg/apache/cordova/inappbrowser/InAppBrowser$7$4;-><init>(Lorg/apache/cordova/inappbrowser/InAppBrowser$7;)V

    invoke-virtual {v4, v5}, Landroid/widget/EditText;->setOnKeyListener(Landroid/view/View$OnKeyListener;)V

    iget-object v4, v0, Lorg/apache/cordova/inappbrowser/InAppBrowser$7;->this$0:Lorg/apache/cordova/inappbrowser/InAppBrowser;

    .line 891
    invoke-static {v4}, Lorg/apache/cordova/inappbrowser/InAppBrowser;->-$$Nest$fgetleftToRight(Lorg/apache/cordova/inappbrowser/InAppBrowser;)Z

    move-result v4

    if-eqz v4, :cond_7

    move v11, v2

    .line 892
    :cond_7
    invoke-direct {v0, v11}, Lorg/apache/cordova/inappbrowser/InAppBrowser$7;->createCloseButton(I)Landroid/view/View;

    move-result-object v4

    .line 893
    invoke-virtual {v3, v4}, Landroid/widget/RelativeLayout;->addView(Landroid/view/View;)V

    .line 896
    new-instance v4, Landroid/widget/RelativeLayout;

    iget-object v5, v0, Lorg/apache/cordova/inappbrowser/InAppBrowser$7;->this$0:Lorg/apache/cordova/inappbrowser/InAppBrowser;

    iget-object v5, v5, Lorg/apache/cordova/inappbrowser/InAppBrowser;->cordova:Lorg/apache/cordova/CordovaInterface;

    invoke-interface {v5}, Lorg/apache/cordova/CordovaInterface;->getActivity()Landroidx/appcompat/app/AppCompatActivity;

    move-result-object v5

    invoke-direct {v4, v5}, Landroid/widget/RelativeLayout;-><init>(Landroid/content/Context;)V

    iget-object v5, v0, Lorg/apache/cordova/inappbrowser/InAppBrowser$7;->this$0:Lorg/apache/cordova/inappbrowser/InAppBrowser;

    .line 898
    invoke-static {v5}, Lorg/apache/cordova/inappbrowser/InAppBrowser;->-$$Nest$fgetfooterColor(Lorg/apache/cordova/inappbrowser/InAppBrowser;)Ljava/lang/String;

    move-result-object v5

    if-eq v5, v10, :cond_8

    iget-object v5, v0, Lorg/apache/cordova/inappbrowser/InAppBrowser$7;->this$0:Lorg/apache/cordova/inappbrowser/InAppBrowser;

    .line 899
    invoke-static {v5}, Lorg/apache/cordova/inappbrowser/InAppBrowser;->-$$Nest$fgetfooterColor(Lorg/apache/cordova/inappbrowser/InAppBrowser;)Ljava/lang/String;

    move-result-object v5

    invoke-static {v5}, Landroid/graphics/Color;->parseColor(Ljava/lang/String;)I

    move-result v5

    goto :goto_3

    :cond_8
    const v5, -0x333334

    .line 903
    :goto_3
    invoke-virtual {v4, v5}, Landroid/widget/RelativeLayout;->setBackgroundColor(I)V

    .line 904
    new-instance v5, Landroid/widget/RelativeLayout$LayoutParams;

    const/16 v11, 0x2c

    invoke-direct {v0, v11}, Lorg/apache/cordova/inappbrowser/InAppBrowser$7;->dpToPixels(I)I

    move-result v11

    invoke-direct {v5, v7, v11}, Landroid/widget/RelativeLayout$LayoutParams;-><init>(II)V

    const/16 v11, 0xc

    .line 905
    invoke-virtual {v5, v11, v7}, Landroid/widget/RelativeLayout$LayoutParams;->addRule(II)V

    .line 906
    invoke-virtual {v4, v5}, Landroid/widget/RelativeLayout;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    iget-object v5, v0, Lorg/apache/cordova/inappbrowser/InAppBrowser$7;->this$0:Lorg/apache/cordova/inappbrowser/InAppBrowser;

    .line 907
    invoke-static {v5}, Lorg/apache/cordova/inappbrowser/InAppBrowser;->-$$Nest$fgetcloseButtonCaption(Lorg/apache/cordova/inappbrowser/InAppBrowser;)Ljava/lang/String;

    move-result-object v5

    if-eq v5, v10, :cond_9

    const/16 v5, 0x8

    invoke-direct {v0, v5}, Lorg/apache/cordova/inappbrowser/InAppBrowser$7;->dpToPixels(I)I

    move-result v10

    invoke-direct {v0, v5}, Lorg/apache/cordova/inappbrowser/InAppBrowser$7;->dpToPixels(I)I

    move-result v11

    invoke-direct {v0, v5}, Lorg/apache/cordova/inappbrowser/InAppBrowser$7;->dpToPixels(I)I

    move-result v13

    invoke-direct {v0, v5}, Lorg/apache/cordova/inappbrowser/InAppBrowser$7;->dpToPixels(I)I

    move-result v5

    invoke-virtual {v4, v10, v11, v13, v5}, Landroid/widget/RelativeLayout;->setPadding(IIII)V

    .line 908
    :cond_9
    invoke-virtual {v4, v8}, Landroid/widget/RelativeLayout;->setHorizontalGravity(I)V

    const/16 v5, 0x50

    .line 909
    invoke-virtual {v4, v5}, Landroid/widget/RelativeLayout;->setVerticalGravity(I)V

    const/4 v5, 0x7

    .line 911
    invoke-direct {v0, v5}, Lorg/apache/cordova/inappbrowser/InAppBrowser$7;->createCloseButton(I)Landroid/view/View;

    move-result-object v5

    .line 912
    invoke-virtual {v4, v5}, Landroid/widget/RelativeLayout;->addView(Landroid/view/View;)V

    iget-object v5, v0, Lorg/apache/cordova/inappbrowser/InAppBrowser$7;->this$0:Lorg/apache/cordova/inappbrowser/InAppBrowser;

    .line 916
    new-instance v8, Landroid/webkit/WebView;

    iget-object v10, v0, Lorg/apache/cordova/inappbrowser/InAppBrowser$7;->this$0:Lorg/apache/cordova/inappbrowser/InAppBrowser;

    iget-object v10, v10, Lorg/apache/cordova/inappbrowser/InAppBrowser;->cordova:Lorg/apache/cordova/CordovaInterface;

    invoke-interface {v10}, Lorg/apache/cordova/CordovaInterface;->getActivity()Landroidx/appcompat/app/AppCompatActivity;

    move-result-object v10

    invoke-direct {v8, v10}, Landroid/webkit/WebView;-><init>(Landroid/content/Context;)V

    invoke-static {v5, v8}, Lorg/apache/cordova/inappbrowser/InAppBrowser;->-$$Nest$fputinAppWebView(Lorg/apache/cordova/inappbrowser/InAppBrowser;Landroid/webkit/WebView;)V

    iget-object v5, v0, Lorg/apache/cordova/inappbrowser/InAppBrowser$7;->this$0:Lorg/apache/cordova/inappbrowser/InAppBrowser;

    .line 917
    invoke-static {v5}, Lorg/apache/cordova/inappbrowser/InAppBrowser;->-$$Nest$fgetinAppWebView(Lorg/apache/cordova/inappbrowser/InAppBrowser;)Landroid/webkit/WebView;

    move-result-object v5

    new-instance v8, Landroid/widget/LinearLayout$LayoutParams;

    invoke-direct {v8, v7, v7}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    invoke-virtual {v5, v8}, Landroid/webkit/WebView;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    iget-object v5, v0, Lorg/apache/cordova/inappbrowser/InAppBrowser$7;->this$0:Lorg/apache/cordova/inappbrowser/InAppBrowser;

    .line 918
    invoke-static {v5}, Lorg/apache/cordova/inappbrowser/InAppBrowser;->-$$Nest$fgetinAppWebView(Lorg/apache/cordova/inappbrowser/InAppBrowser;)Landroid/webkit/WebView;

    move-result-object v5

    const/4 v8, 0x6

    invoke-static {v8}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v10

    invoke-virtual {v10}, Ljava/lang/Integer;->intValue()I

    move-result v10

    invoke-virtual {v5, v10}, Landroid/webkit/WebView;->setId(I)V

    iget-object v5, v0, Lorg/apache/cordova/inappbrowser/InAppBrowser$7;->this$0:Lorg/apache/cordova/inappbrowser/InAppBrowser;

    .line 920
    invoke-static {v5}, Lorg/apache/cordova/inappbrowser/InAppBrowser;->-$$Nest$fgetinAppWebView(Lorg/apache/cordova/inappbrowser/InAppBrowser;)Landroid/webkit/WebView;

    move-result-object v5

    new-instance v10, Lorg/apache/cordova/inappbrowser/InAppBrowser$7$5;

    iget-object v11, v0, Lorg/apache/cordova/inappbrowser/InAppBrowser$7;->val$thatWebView:Lorg/apache/cordova/CordovaWebView;

    invoke-direct {v10, v0, v11}, Lorg/apache/cordova/inappbrowser/InAppBrowser$7$5;-><init>(Lorg/apache/cordova/inappbrowser/InAppBrowser$7;Lorg/apache/cordova/CordovaWebView;)V

    invoke-virtual {v5, v10}, Landroid/webkit/WebView;->setWebChromeClient(Landroid/webkit/WebChromeClient;)V

    iget-object v5, v0, Lorg/apache/cordova/inappbrowser/InAppBrowser$7;->this$0:Lorg/apache/cordova/inappbrowser/InAppBrowser;

    .line 940
    new-instance v10, Lorg/apache/cordova/inappbrowser/InAppBrowser$InAppBrowserClient;

    iget-object v11, v0, Lorg/apache/cordova/inappbrowser/InAppBrowser$7;->this$0:Lorg/apache/cordova/inappbrowser/InAppBrowser;

    iget-object v13, v0, Lorg/apache/cordova/inappbrowser/InAppBrowser$7;->val$thatWebView:Lorg/apache/cordova/CordovaWebView;

    invoke-static {v11}, Lorg/apache/cordova/inappbrowser/InAppBrowser;->-$$Nest$fgetedittext(Lorg/apache/cordova/inappbrowser/InAppBrowser;)Landroid/widget/EditText;

    move-result-object v15

    iget-object v7, v0, Lorg/apache/cordova/inappbrowser/InAppBrowser$7;->this$0:Lorg/apache/cordova/inappbrowser/InAppBrowser;

    invoke-static {v7}, Lorg/apache/cordova/inappbrowser/InAppBrowser;->-$$Nest$fgetbeforeload(Lorg/apache/cordova/inappbrowser/InAppBrowser;)Ljava/lang/String;

    move-result-object v7

    invoke-direct {v10, v11, v13, v15, v7}, Lorg/apache/cordova/inappbrowser/InAppBrowser$InAppBrowserClient;-><init>(Lorg/apache/cordova/inappbrowser/InAppBrowser;Lorg/apache/cordova/CordovaWebView;Landroid/widget/EditText;Ljava/lang/String;)V

    invoke-static {v5, v10}, Lorg/apache/cordova/inappbrowser/InAppBrowser;->-$$Nest$fputcurrentClient(Lorg/apache/cordova/inappbrowser/InAppBrowser;Lorg/apache/cordova/inappbrowser/InAppBrowser$InAppBrowserClient;)V

    iget-object v5, v0, Lorg/apache/cordova/inappbrowser/InAppBrowser$7;->this$0:Lorg/apache/cordova/inappbrowser/InAppBrowser;

    .line 941
    invoke-static {v5}, Lorg/apache/cordova/inappbrowser/InAppBrowser;->-$$Nest$fgetinAppWebView(Lorg/apache/cordova/inappbrowser/InAppBrowser;)Landroid/webkit/WebView;

    move-result-object v5

    iget-object v7, v0, Lorg/apache/cordova/inappbrowser/InAppBrowser$7;->this$0:Lorg/apache/cordova/inappbrowser/InAppBrowser;

    invoke-static {v7}, Lorg/apache/cordova/inappbrowser/InAppBrowser;->-$$Nest$fgetcurrentClient(Lorg/apache/cordova/inappbrowser/InAppBrowser;)Lorg/apache/cordova/inappbrowser/InAppBrowser$InAppBrowserClient;

    move-result-object v7

    invoke-virtual {v5, v7}, Landroid/webkit/WebView;->setWebViewClient(Landroid/webkit/WebViewClient;)V

    iget-object v5, v0, Lorg/apache/cordova/inappbrowser/InAppBrowser$7;->this$0:Lorg/apache/cordova/inappbrowser/InAppBrowser;

    .line 942
    invoke-static {v5}, Lorg/apache/cordova/inappbrowser/InAppBrowser;->-$$Nest$fgetinAppWebView(Lorg/apache/cordova/inappbrowser/InAppBrowser;)Landroid/webkit/WebView;

    move-result-object v5

    invoke-virtual {v5}, Landroid/webkit/WebView;->getSettings()Landroid/webkit/WebSettings;

    move-result-object v5

    .line 943
    invoke-virtual {v5, v2}, Landroid/webkit/WebSettings;->setJavaScriptEnabled(Z)V

    .line 944
    invoke-virtual {v5, v2}, Landroid/webkit/WebSettings;->setJavaScriptCanOpenWindowsAutomatically(Z)V

    iget-object v7, v0, Lorg/apache/cordova/inappbrowser/InAppBrowser$7;->this$0:Lorg/apache/cordova/inappbrowser/InAppBrowser;

    .line 945
    invoke-static {v7}, Lorg/apache/cordova/inappbrowser/InAppBrowser;->-$$Nest$fgetshowZoomControls(Lorg/apache/cordova/inappbrowser/InAppBrowser;)Z

    move-result v7

    invoke-virtual {v5, v7}, Landroid/webkit/WebSettings;->setBuiltInZoomControls(Z)V

    .line 946
    sget-object v7, Landroid/webkit/WebSettings$PluginState;->ON:Landroid/webkit/WebSettings$PluginState;

    invoke-virtual {v5, v7}, Landroid/webkit/WebSettings;->setPluginState(Landroid/webkit/WebSettings$PluginState;)V

    iget-object v7, v0, Lorg/apache/cordova/inappbrowser/InAppBrowser$7;->this$0:Lorg/apache/cordova/inappbrowser/InAppBrowser;

    .line 963
    invoke-static {v7}, Lorg/apache/cordova/inappbrowser/InAppBrowser;->-$$Nest$fgetmediaPlaybackRequiresUserGesture(Lorg/apache/cordova/inappbrowser/InAppBrowser;)Z

    move-result v7

    invoke-virtual {v5, v7}, Landroid/webkit/WebSettings;->setMediaPlaybackRequiresUserGesture(Z)V

    iget-object v7, v0, Lorg/apache/cordova/inappbrowser/InAppBrowser$7;->this$0:Lorg/apache/cordova/inappbrowser/InAppBrowser;

    .line 964
    invoke-static {v7}, Lorg/apache/cordova/inappbrowser/InAppBrowser;->-$$Nest$fgetinAppWebView(Lorg/apache/cordova/inappbrowser/InAppBrowser;)Landroid/webkit/WebView;

    move-result-object v7

    new-instance v10, Lorg/apache/cordova/inappbrowser/InAppBrowser$7$1JsObject;

    invoke-direct {v10, v0}, Lorg/apache/cordova/inappbrowser/InAppBrowser$7$1JsObject;-><init>(Lorg/apache/cordova/inappbrowser/InAppBrowser$7;)V

    const-string v11, "cordova_iab"

    invoke-virtual {v7, v10, v11}, Landroid/webkit/WebView;->addJavascriptInterface(Ljava/lang/Object;Ljava/lang/String;)V

    iget-object v7, v0, Lorg/apache/cordova/inappbrowser/InAppBrowser$7;->this$0:Lorg/apache/cordova/inappbrowser/InAppBrowser;

    .line 966
    invoke-static {v7}, Lorg/apache/cordova/inappbrowser/InAppBrowser;->access$000(Lorg/apache/cordova/inappbrowser/InAppBrowser;)Lorg/apache/cordova/CordovaPreferences;

    move-result-object v7

    const-string v10, "OverrideUserAgent"

    const/4 v11, 0x0

    invoke-virtual {v7, v10, v11}, Lorg/apache/cordova/CordovaPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v7

    iget-object v10, v0, Lorg/apache/cordova/inappbrowser/InAppBrowser$7;->this$0:Lorg/apache/cordova/inappbrowser/InAppBrowser;

    .line 967
    invoke-static {v10}, Lorg/apache/cordova/inappbrowser/InAppBrowser;->access$100(Lorg/apache/cordova/inappbrowser/InAppBrowser;)Lorg/apache/cordova/CordovaPreferences;

    move-result-object v10

    const-string v13, "AppendUserAgent"

    invoke-virtual {v10, v13, v11}, Lorg/apache/cordova/CordovaPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v10

    if-eqz v7, :cond_a

    .line 970
    invoke-virtual {v5, v7}, Landroid/webkit/WebSettings;->setUserAgentString(Ljava/lang/String;)V

    :cond_a
    if-eqz v10, :cond_b

    .line 973
    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v5}, Landroid/webkit/WebSettings;->getUserAgentString()Ljava/lang/String;

    move-result-object v11

    invoke-virtual {v7, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v5, v7}, Landroid/webkit/WebSettings;->setUserAgentString(Ljava/lang/String;)V

    :cond_b
    iget-object v7, v0, Lorg/apache/cordova/inappbrowser/InAppBrowser$7;->this$0:Lorg/apache/cordova/inappbrowser/InAppBrowser;

    .line 977
    iget-object v7, v7, Lorg/apache/cordova/inappbrowser/InAppBrowser;->cordova:Lorg/apache/cordova/CordovaInterface;

    invoke-interface {v7}, Lorg/apache/cordova/CordovaInterface;->getActivity()Landroidx/appcompat/app/AppCompatActivity;

    move-result-object v7

    invoke-virtual {v7}, Landroidx/appcompat/app/AppCompatActivity;->getIntent()Landroid/content/Intent;

    move-result-object v7

    invoke-virtual {v7}, Landroid/content/Intent;->getExtras()Landroid/os/Bundle;

    move-result-object v7

    if-nez v7, :cond_c

    goto :goto_4

    :cond_c
    const-string v10, "InAppBrowserStorageEnabled"

    .line 978
    invoke-virtual {v7, v10, v2}, Landroid/os/Bundle;->getBoolean(Ljava/lang/String;Z)Z

    move-result v7

    if-eqz v7, :cond_d

    :goto_4
    iget-object v7, v0, Lorg/apache/cordova/inappbrowser/InAppBrowser$7;->this$0:Lorg/apache/cordova/inappbrowser/InAppBrowser;

    .line 980
    iget-object v7, v7, Lorg/apache/cordova/inappbrowser/InAppBrowser;->cordova:Lorg/apache/cordova/CordovaInterface;

    invoke-interface {v7}, Lorg/apache/cordova/CordovaInterface;->getActivity()Landroidx/appcompat/app/AppCompatActivity;

    move-result-object v7

    invoke-virtual {v7}, Landroidx/appcompat/app/AppCompatActivity;->getApplicationContext()Landroid/content/Context;

    move-result-object v7

    const-string v10, "inAppBrowserDB"

    invoke-virtual {v7, v10, v14}, Landroid/content/Context;->getDir(Ljava/lang/String;I)Ljava/io/File;

    move-result-object v7

    invoke-virtual {v7}, Ljava/io/File;->getPath()Ljava/lang/String;

    move-result-object v7

    .line 981
    invoke-virtual {v5, v7}, Landroid/webkit/WebSettings;->setDatabasePath(Ljava/lang/String;)V

    .line 982
    invoke-virtual {v5, v2}, Landroid/webkit/WebSettings;->setDatabaseEnabled(Z)V

    .line 984
    :cond_d
    invoke-virtual {v5, v2}, Landroid/webkit/WebSettings;->setDomStorageEnabled(Z)V

    iget-object v5, v0, Lorg/apache/cordova/inappbrowser/InAppBrowser$7;->this$0:Lorg/apache/cordova/inappbrowser/InAppBrowser;

    .line 986
    invoke-static {v5}, Lorg/apache/cordova/inappbrowser/InAppBrowser;->-$$Nest$fgetclearAllCache(Lorg/apache/cordova/inappbrowser/InAppBrowser;)Z

    move-result v5

    if-eqz v5, :cond_e

    .line 987
    invoke-static {}, Landroid/webkit/CookieManager;->getInstance()Landroid/webkit/CookieManager;

    move-result-object v5

    invoke-virtual {v5}, Landroid/webkit/CookieManager;->removeAllCookie()V

    goto :goto_5

    :cond_e
    iget-object v5, v0, Lorg/apache/cordova/inappbrowser/InAppBrowser$7;->this$0:Lorg/apache/cordova/inappbrowser/InAppBrowser;

    .line 988
    invoke-static {v5}, Lorg/apache/cordova/inappbrowser/InAppBrowser;->-$$Nest$fgetclearSessionCache(Lorg/apache/cordova/inappbrowser/InAppBrowser;)Z

    move-result v5

    if-eqz v5, :cond_f

    .line 989
    invoke-static {}, Landroid/webkit/CookieManager;->getInstance()Landroid/webkit/CookieManager;

    move-result-object v5

    invoke-virtual {v5}, Landroid/webkit/CookieManager;->removeSessionCookie()V

    .line 993
    :cond_f
    :goto_5
    invoke-static {}, Landroid/webkit/CookieManager;->getInstance()Landroid/webkit/CookieManager;

    move-result-object v5

    iget-object v7, v0, Lorg/apache/cordova/inappbrowser/InAppBrowser$7;->this$0:Lorg/apache/cordova/inappbrowser/InAppBrowser;

    invoke-static {v7}, Lorg/apache/cordova/inappbrowser/InAppBrowser;->-$$Nest$fgetinAppWebView(Lorg/apache/cordova/inappbrowser/InAppBrowser;)Landroid/webkit/WebView;

    move-result-object v7

    invoke-virtual {v5, v7, v2}, Landroid/webkit/CookieManager;->setAcceptThirdPartyCookies(Landroid/webkit/WebView;Z)V

    iget-object v5, v0, Lorg/apache/cordova/inappbrowser/InAppBrowser$7;->this$0:Lorg/apache/cordova/inappbrowser/InAppBrowser;

    .line 995
    invoke-static {v5}, Lorg/apache/cordova/inappbrowser/InAppBrowser;->-$$Nest$fgetinAppWebView(Lorg/apache/cordova/inappbrowser/InAppBrowser;)Landroid/webkit/WebView;

    move-result-object v5

    iget-object v7, v0, Lorg/apache/cordova/inappbrowser/InAppBrowser$7;->val$url:Ljava/lang/String;

    invoke-virtual {v5, v7}, Landroid/webkit/WebView;->loadUrl(Ljava/lang/String;)V

    iget-object v5, v0, Lorg/apache/cordova/inappbrowser/InAppBrowser$7;->this$0:Lorg/apache/cordova/inappbrowser/InAppBrowser;

    .line 996
    invoke-static {v5}, Lorg/apache/cordova/inappbrowser/InAppBrowser;->-$$Nest$fgetinAppWebView(Lorg/apache/cordova/inappbrowser/InAppBrowser;)Landroid/webkit/WebView;

    move-result-object v5

    invoke-static {v8}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/Integer;->intValue()I

    move-result v7

    invoke-virtual {v5, v7}, Landroid/webkit/WebView;->setId(I)V

    iget-object v5, v0, Lorg/apache/cordova/inappbrowser/InAppBrowser$7;->this$0:Lorg/apache/cordova/inappbrowser/InAppBrowser;

    .line 997
    invoke-static {v5}, Lorg/apache/cordova/inappbrowser/InAppBrowser;->-$$Nest$fgetinAppWebView(Lorg/apache/cordova/inappbrowser/InAppBrowser;)Landroid/webkit/WebView;

    move-result-object v5

    invoke-virtual {v5}, Landroid/webkit/WebView;->getSettings()Landroid/webkit/WebSettings;

    move-result-object v5

    invoke-virtual {v5, v2}, Landroid/webkit/WebSettings;->setLoadWithOverviewMode(Z)V

    iget-object v5, v0, Lorg/apache/cordova/inappbrowser/InAppBrowser$7;->this$0:Lorg/apache/cordova/inappbrowser/InAppBrowser;

    .line 998
    invoke-static {v5}, Lorg/apache/cordova/inappbrowser/InAppBrowser;->-$$Nest$fgetinAppWebView(Lorg/apache/cordova/inappbrowser/InAppBrowser;)Landroid/webkit/WebView;

    move-result-object v5

    invoke-virtual {v5}, Landroid/webkit/WebView;->getSettings()Landroid/webkit/WebSettings;

    move-result-object v5

    iget-object v7, v0, Lorg/apache/cordova/inappbrowser/InAppBrowser$7;->this$0:Lorg/apache/cordova/inappbrowser/InAppBrowser;

    invoke-static {v7}, Lorg/apache/cordova/inappbrowser/InAppBrowser;->-$$Nest$fgetuseWideViewPort(Lorg/apache/cordova/inappbrowser/InAppBrowser;)Z

    move-result v7

    invoke-virtual {v5, v7}, Landroid/webkit/WebSettings;->setUseWideViewPort(Z)V

    iget-object v5, v0, Lorg/apache/cordova/inappbrowser/InAppBrowser$7;->this$0:Lorg/apache/cordova/inappbrowser/InAppBrowser;

    .line 1001
    invoke-static {v5}, Lorg/apache/cordova/inappbrowser/InAppBrowser;->-$$Nest$fgetinAppWebView(Lorg/apache/cordova/inappbrowser/InAppBrowser;)Landroid/webkit/WebView;

    move-result-object v5

    invoke-virtual {v5}, Landroid/webkit/WebView;->getSettings()Landroid/webkit/WebSettings;

    move-result-object v5

    invoke-virtual {v5, v2}, Landroid/webkit/WebSettings;->setSupportMultipleWindows(Z)V

    iget-object v2, v0, Lorg/apache/cordova/inappbrowser/InAppBrowser$7;->this$0:Lorg/apache/cordova/inappbrowser/InAppBrowser;

    .line 1002
    invoke-static {v2}, Lorg/apache/cordova/inappbrowser/InAppBrowser;->-$$Nest$fgetinAppWebView(Lorg/apache/cordova/inappbrowser/InAppBrowser;)Landroid/webkit/WebView;

    move-result-object v2

    invoke-virtual {v2}, Landroid/webkit/WebView;->requestFocus()Z

    iget-object v2, v0, Lorg/apache/cordova/inappbrowser/InAppBrowser$7;->this$0:Lorg/apache/cordova/inappbrowser/InAppBrowser;

    .line 1003
    invoke-static {v2}, Lorg/apache/cordova/inappbrowser/InAppBrowser;->-$$Nest$fgetinAppWebView(Lorg/apache/cordova/inappbrowser/InAppBrowser;)Landroid/webkit/WebView;

    move-result-object v2

    invoke-virtual {v2}, Landroid/webkit/WebView;->requestFocusFromTouch()Z

    .line 1006
    invoke-virtual {v6, v12}, Landroid/widget/RelativeLayout;->addView(Landroid/view/View;)V

    .line 1007
    invoke-virtual {v6, v9}, Landroid/widget/RelativeLayout;->addView(Landroid/view/View;)V

    iget-object v2, v0, Lorg/apache/cordova/inappbrowser/InAppBrowser$7;->this$0:Lorg/apache/cordova/inappbrowser/InAppBrowser;

    .line 1010
    invoke-static {v2}, Lorg/apache/cordova/inappbrowser/InAppBrowser;->-$$Nest$fgethideNavigationButtons(Lorg/apache/cordova/inappbrowser/InAppBrowser;)Z

    move-result v2

    if-nez v2, :cond_10

    invoke-virtual {v3, v6}, Landroid/widget/RelativeLayout;->addView(Landroid/view/View;)V

    :cond_10
    iget-object v2, v0, Lorg/apache/cordova/inappbrowser/InAppBrowser$7;->this$0:Lorg/apache/cordova/inappbrowser/InAppBrowser;

    .line 1011
    invoke-static {v2}, Lorg/apache/cordova/inappbrowser/InAppBrowser;->-$$Nest$fgethideUrlBar(Lorg/apache/cordova/inappbrowser/InAppBrowser;)Z

    move-result v2

    if-nez v2, :cond_11

    iget-object v2, v0, Lorg/apache/cordova/inappbrowser/InAppBrowser$7;->this$0:Lorg/apache/cordova/inappbrowser/InAppBrowser;

    invoke-static {v2}, Lorg/apache/cordova/inappbrowser/InAppBrowser;->-$$Nest$fgetedittext(Lorg/apache/cordova/inappbrowser/InAppBrowser;)Landroid/widget/EditText;

    move-result-object v2

    invoke-virtual {v3, v2}, Landroid/widget/RelativeLayout;->addView(Landroid/view/View;)V

    :cond_11
    iget-object v2, v0, Lorg/apache/cordova/inappbrowser/InAppBrowser$7;->this$0:Lorg/apache/cordova/inappbrowser/InAppBrowser;

    .line 1014
    invoke-static {v2}, Lorg/apache/cordova/inappbrowser/InAppBrowser;->-$$Nest$mgetShowLocationBar(Lorg/apache/cordova/inappbrowser/InAppBrowser;)Z

    move-result v2

    if-eqz v2, :cond_12

    .line 1016
    invoke-virtual {v1, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 1020
    :cond_12
    new-instance v2, Landroid/widget/RelativeLayout;

    iget-object v3, v0, Lorg/apache/cordova/inappbrowser/InAppBrowser$7;->this$0:Lorg/apache/cordova/inappbrowser/InAppBrowser;

    iget-object v3, v3, Lorg/apache/cordova/inappbrowser/InAppBrowser;->cordova:Lorg/apache/cordova/CordovaInterface;

    invoke-interface {v3}, Lorg/apache/cordova/CordovaInterface;->getActivity()Landroidx/appcompat/app/AppCompatActivity;

    move-result-object v3

    invoke-direct {v2, v3}, Landroid/widget/RelativeLayout;-><init>(Landroid/content/Context;)V

    iget-object v3, v0, Lorg/apache/cordova/inappbrowser/InAppBrowser$7;->this$0:Lorg/apache/cordova/inappbrowser/InAppBrowser;

    .line 1021
    invoke-static {v3}, Lorg/apache/cordova/inappbrowser/InAppBrowser;->-$$Nest$fgetinAppWebView(Lorg/apache/cordova/inappbrowser/InAppBrowser;)Landroid/webkit/WebView;

    move-result-object v3

    invoke-virtual {v2, v3}, Landroid/widget/RelativeLayout;->addView(Landroid/view/View;)V

    .line 1022
    invoke-virtual {v1, v2}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    iget-object v3, v0, Lorg/apache/cordova/inappbrowser/InAppBrowser$7;->this$0:Lorg/apache/cordova/inappbrowser/InAppBrowser;

    .line 1025
    invoke-static {v3}, Lorg/apache/cordova/inappbrowser/InAppBrowser;->-$$Nest$fgetshowFooter(Lorg/apache/cordova/inappbrowser/InAppBrowser;)Z

    move-result v3

    if-eqz v3, :cond_13

    .line 1026
    invoke-virtual {v2, v4}, Landroid/widget/RelativeLayout;->addView(Landroid/view/View;)V

    .line 1029
    :cond_13
    new-instance v2, Landroid/view/WindowManager$LayoutParams;

    invoke-direct {v2}, Landroid/view/WindowManager$LayoutParams;-><init>()V

    iget-object v3, v0, Lorg/apache/cordova/inappbrowser/InAppBrowser$7;->this$0:Lorg/apache/cordova/inappbrowser/InAppBrowser;

    .line 1030
    invoke-static {v3}, Lorg/apache/cordova/inappbrowser/InAppBrowser;->-$$Nest$fgetdialog(Lorg/apache/cordova/inappbrowser/InAppBrowser;)Lorg/apache/cordova/inappbrowser/InAppBrowserDialog;

    move-result-object v3

    invoke-virtual {v3}, Lorg/apache/cordova/inappbrowser/InAppBrowserDialog;->getWindow()Landroid/view/Window;

    move-result-object v3

    invoke-virtual {v3}, Landroid/view/Window;->getAttributes()Landroid/view/WindowManager$LayoutParams;

    move-result-object v3

    invoke-virtual {v2, v3}, Landroid/view/WindowManager$LayoutParams;->copyFrom(Landroid/view/WindowManager$LayoutParams;)I

    const/4 v3, -0x1

    .line 1031
    iput v3, v2, Landroid/view/WindowManager$LayoutParams;->width:I

    .line 1032
    iput v3, v2, Landroid/view/WindowManager$LayoutParams;->height:I

    iget-object v3, v0, Lorg/apache/cordova/inappbrowser/InAppBrowser$7;->this$0:Lorg/apache/cordova/inappbrowser/InAppBrowser;

    .line 1034
    invoke-static {v3}, Lorg/apache/cordova/inappbrowser/InAppBrowser;->-$$Nest$fgetdialog(Lorg/apache/cordova/inappbrowser/InAppBrowser;)Lorg/apache/cordova/inappbrowser/InAppBrowserDialog;

    move-result-object v3

    if-eqz v3, :cond_14

    iget-object v3, v0, Lorg/apache/cordova/inappbrowser/InAppBrowser$7;->this$0:Lorg/apache/cordova/inappbrowser/InAppBrowser;

    .line 1035
    invoke-static {v3}, Lorg/apache/cordova/inappbrowser/InAppBrowser;->-$$Nest$fgetdialog(Lorg/apache/cordova/inappbrowser/InAppBrowser;)Lorg/apache/cordova/inappbrowser/InAppBrowserDialog;

    move-result-object v3

    invoke-virtual {v3, v1}, Lorg/apache/cordova/inappbrowser/InAppBrowserDialog;->setContentView(Landroid/view/View;)V

    iget-object v1, v0, Lorg/apache/cordova/inappbrowser/InAppBrowser$7;->this$0:Lorg/apache/cordova/inappbrowser/InAppBrowser;

    .line 1036
    invoke-static {v1}, Lorg/apache/cordova/inappbrowser/InAppBrowser;->-$$Nest$fgetdialog(Lorg/apache/cordova/inappbrowser/InAppBrowser;)Lorg/apache/cordova/inappbrowser/InAppBrowserDialog;

    move-result-object v1

    invoke-virtual {v1}, Lorg/apache/cordova/inappbrowser/InAppBrowserDialog;->show()V

    iget-object v1, v0, Lorg/apache/cordova/inappbrowser/InAppBrowser$7;->this$0:Lorg/apache/cordova/inappbrowser/InAppBrowser;

    .line 1037
    invoke-static {v1}, Lorg/apache/cordova/inappbrowser/InAppBrowser;->-$$Nest$fgetdialog(Lorg/apache/cordova/inappbrowser/InAppBrowser;)Lorg/apache/cordova/inappbrowser/InAppBrowserDialog;

    move-result-object v1

    invoke-virtual {v1}, Lorg/apache/cordova/inappbrowser/InAppBrowserDialog;->getWindow()Landroid/view/Window;

    move-result-object v1

    invoke-virtual {v1, v2}, Landroid/view/Window;->setAttributes(Landroid/view/WindowManager$LayoutParams;)V

    :cond_14
    iget-object v1, v0, Lorg/apache/cordova/inappbrowser/InAppBrowser$7;->this$0:Lorg/apache/cordova/inappbrowser/InAppBrowser;

    .line 1041
    invoke-static {v1}, Lorg/apache/cordova/inappbrowser/InAppBrowser;->-$$Nest$fgetopenWindowHidden(Lorg/apache/cordova/inappbrowser/InAppBrowser;)Z

    move-result v1

    if-eqz v1, :cond_15

    iget-object v1, v0, Lorg/apache/cordova/inappbrowser/InAppBrowser$7;->this$0:Lorg/apache/cordova/inappbrowser/InAppBrowser;

    invoke-static {v1}, Lorg/apache/cordova/inappbrowser/InAppBrowser;->-$$Nest$fgetdialog(Lorg/apache/cordova/inappbrowser/InAppBrowser;)Lorg/apache/cordova/inappbrowser/InAppBrowserDialog;

    move-result-object v1

    if-eqz v1, :cond_15

    iget-object v1, v0, Lorg/apache/cordova/inappbrowser/InAppBrowser$7;->this$0:Lorg/apache/cordova/inappbrowser/InAppBrowser;

    .line 1042
    invoke-static {v1}, Lorg/apache/cordova/inappbrowser/InAppBrowser;->-$$Nest$fgetdialog(Lorg/apache/cordova/inappbrowser/InAppBrowser;)Lorg/apache/cordova/inappbrowser/InAppBrowserDialog;

    move-result-object v1

    invoke-virtual {v1}, Lorg/apache/cordova/inappbrowser/InAppBrowserDialog;->hide()V

    :cond_15
    return-void
.end method
