.class Lcom/taobao/application/common/impl/AppPreferencesImpl$b;
.super Ljava/lang/Object;
.source "AppPreferencesImpl.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/taobao/application/common/impl/AppPreferencesImpl;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0xa
    name = "b"
.end annotation


# static fields
.field static final a:Lcom/taobao/application/common/impl/AppPreferencesImpl;


# direct methods
.method static constructor <clinit>()V
    .locals 2

    .line 1
    new-instance v0, Lcom/taobao/application/common/impl/AppPreferencesImpl;

    const/4 v1, 0x0

    invoke-direct {v0, v1}, Lcom/taobao/application/common/impl/AppPreferencesImpl;-><init>(Lcom/taobao/application/common/impl/AppPreferencesImpl$a;)V

    sput-object v0, Lcom/taobao/application/common/impl/AppPreferencesImpl$b;->a:Lcom/taobao/application/common/impl/AppPreferencesImpl;

    return-void
.end method
