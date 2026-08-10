.class public Lcom/taobao/application/common/data/d;
.super Lcom/taobao/application/common/data/a;
.source "BackgroundForegroundHelper.java"


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 1
    invoke-direct {p0}, Lcom/taobao/application/common/data/a;-><init>()V

    return-void
.end method


# virtual methods
.method public a(Z)V
    .locals 2

    .line 1
    iget-object v0, p0, Lcom/taobao/application/common/data/a;->preferences:Lcom/taobao/application/common/impl/AppPreferencesImpl;

    const-string v1, "isInBackground"

    invoke-virtual {v0, v1, p1}, Lcom/taobao/application/common/impl/AppPreferencesImpl;->putBoolean(Ljava/lang/String;Z)V

    return-void
.end method

.method public b(Z)V
    .locals 2

    .line 1
    iget-object v0, p0, Lcom/taobao/application/common/data/a;->preferences:Lcom/taobao/application/common/impl/AppPreferencesImpl;

    const-string v1, "isFullInBackground"

    invoke-virtual {v0, v1, p1}, Lcom/taobao/application/common/impl/AppPreferencesImpl;->putBoolean(Ljava/lang/String;Z)V

    return-void
.end method
