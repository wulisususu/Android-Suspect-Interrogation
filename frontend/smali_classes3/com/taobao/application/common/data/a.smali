.class abstract Lcom/taobao/application/common/data/a;
.super Ljava/lang/Object;
.source "AbstractHelper.java"


# instance fields
.field protected final preferences:Lcom/taobao/application/common/impl/AppPreferencesImpl;


# direct methods
.method constructor <init>()V
    .locals 1

    .line 1
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 3
    invoke-static {}, Lcom/taobao/application/common/impl/AppPreferencesImpl;->instance()Lcom/taobao/application/common/impl/AppPreferencesImpl;

    move-result-object v0

    iput-object v0, p0, Lcom/taobao/application/common/data/a;->preferences:Lcom/taobao/application/common/impl/AppPreferencesImpl;

    return-void
.end method
