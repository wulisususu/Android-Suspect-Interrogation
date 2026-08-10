.class Lcom/taobao/monitor/adapter/SimpleApmInitiator$3;
.super Lcom/taobao/monitor/impl/data/AbsWebView;
.source "SimpleApmInitiator.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/taobao/monitor/adapter/SimpleApmInitiator;->initWebView()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field private lastUrl:Ljava/lang/String;

.field final synthetic this$0:Lcom/taobao/monitor/adapter/SimpleApmInitiator;


# direct methods
.method constructor <init>(Lcom/taobao/monitor/adapter/SimpleApmInitiator;)V
    .locals 0
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x8010
        }
        names = {
            "this$0"
        }
    .end annotation

    iput-object p1, p0, Lcom/taobao/monitor/adapter/SimpleApmInitiator$3;->this$0:Lcom/taobao/monitor/adapter/SimpleApmInitiator;

    .line 199
    invoke-direct {p0}, Lcom/taobao/monitor/impl/data/AbsWebView;-><init>()V

    return-void
.end method


# virtual methods
.method public getProgress(Landroid/view/View;)I
    .locals 2
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x0
        }
        names = {
            "view"
        }
    .end annotation

    .line 209
    check-cast p1, Landroid/webkit/WebView;

    .line 210
    invoke-virtual {p1}, Landroid/webkit/WebView;->getUrl()Ljava/lang/String;

    move-result-object v0

    iget-object v1, p0, Lcom/taobao/monitor/adapter/SimpleApmInitiator$3;->lastUrl:Ljava/lang/String;

    .line 212
    invoke-static {v1, v0}, Landroid/text/TextUtils;->equals(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Z

    move-result v1

    if-nez v1, :cond_0

    iput-object v0, p0, Lcom/taobao/monitor/adapter/SimpleApmInitiator$3;->lastUrl:Ljava/lang/String;

    const/4 p1, 0x0

    return p1

    .line 217
    :cond_0
    invoke-virtual {p1}, Landroid/webkit/WebView;->getProgress()I

    move-result p1

    return p1
.end method

.method public isWebView(Landroid/view/View;)Z
    .locals 0
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x0
        }
        names = {
            "view"
        }
    .end annotation

    .line 204
    instance-of p1, p1, Landroid/webkit/WebView;

    return p1
.end method
