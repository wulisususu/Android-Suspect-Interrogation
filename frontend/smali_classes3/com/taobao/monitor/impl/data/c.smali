.class public Lcom/taobao/monitor/impl/data/c;
.super Lcom/taobao/monitor/impl/data/AbsWebView;
.source "DefaultWebView.java"


# static fields
.field public static final a:Lcom/taobao/monitor/impl/data/c;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .line 1
    new-instance v0, Lcom/taobao/monitor/impl/data/c;

    invoke-direct {v0}, Lcom/taobao/monitor/impl/data/c;-><init>()V

    sput-object v0, Lcom/taobao/monitor/impl/data/c;->a:Lcom/taobao/monitor/impl/data/c;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .line 1
    invoke-direct {p0}, Lcom/taobao/monitor/impl/data/AbsWebView;-><init>()V

    return-void
.end method


# virtual methods
.method public getProgress(Landroid/view/View;)I
    .locals 0

    .line 1
    check-cast p1, Landroid/webkit/WebView;

    invoke-virtual {p1}, Landroid/webkit/WebView;->getProgress()I

    move-result p1

    return p1
.end method

.method public isWebView(Landroid/view/View;)Z
    .locals 0

    .line 1
    instance-of p1, p1, Landroid/webkit/WebView;

    return p1
.end method
