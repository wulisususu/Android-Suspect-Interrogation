.class public Lcom/taobao/monitor/impl/data/WebViewProxy;
.super Ljava/lang/Object;
.source "WebViewProxy.java"

# interfaces
.implements Lcom/taobao/monitor/impl/data/IWebView;


# static fields
.field public static final INSTANCE:Lcom/taobao/monitor/impl/data/WebViewProxy;


# instance fields
.field private real:Lcom/taobao/monitor/impl/data/IWebView;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .line 1
    new-instance v0, Lcom/taobao/monitor/impl/data/WebViewProxy;

    invoke-direct {v0}, Lcom/taobao/monitor/impl/data/WebViewProxy;-><init>()V

    sput-object v0, Lcom/taobao/monitor/impl/data/WebViewProxy;->INSTANCE:Lcom/taobao/monitor/impl/data/WebViewProxy;

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .line 1
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public isWebView(Landroid/view/View;)Z
    .locals 1

    iget-object v0, p0, Lcom/taobao/monitor/impl/data/WebViewProxy;->real:Lcom/taobao/monitor/impl/data/IWebView;

    if-eqz v0, :cond_0

    .line 2
    invoke-interface {v0, p1}, Lcom/taobao/monitor/impl/data/IWebView;->isWebView(Landroid/view/View;)Z

    move-result p1

    return p1

    :cond_0
    const/4 p1, 0x0

    return p1
.end method

.method public isWebViewLoadFinished(Landroid/view/View;)Z
    .locals 1

    iget-object v0, p0, Lcom/taobao/monitor/impl/data/WebViewProxy;->real:Lcom/taobao/monitor/impl/data/IWebView;

    if-eqz v0, :cond_0

    .line 2
    invoke-interface {v0, p1}, Lcom/taobao/monitor/impl/data/IWebView;->isWebViewLoadFinished(Landroid/view/View;)Z

    move-result p1

    return p1

    :cond_0
    const/4 p1, 0x0

    return p1
.end method

.method public setReal(Lcom/taobao/monitor/impl/data/IWebView;)Lcom/taobao/monitor/impl/data/WebViewProxy;
    .locals 0

    iput-object p1, p0, Lcom/taobao/monitor/impl/data/WebViewProxy;->real:Lcom/taobao/monitor/impl/data/IWebView;

    return-object p0
.end method
