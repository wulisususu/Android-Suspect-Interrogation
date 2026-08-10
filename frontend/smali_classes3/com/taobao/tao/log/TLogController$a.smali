.class Lcom/taobao/tao/log/TLogController$a;
.super Ljava/lang/Object;
.source "TLogController.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/taobao/tao/log/TLogController;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0xa
    name = "a"
.end annotation


# static fields
.field private static final a:Lcom/taobao/tao/log/TLogController;


# direct methods
.method static constructor <clinit>()V
    .locals 2

    .line 26
    new-instance v0, Lcom/taobao/tao/log/TLogController;

    const/4 v1, 0x0

    invoke-direct {v0, v1}, Lcom/taobao/tao/log/TLogController;-><init>(Lcom/taobao/tao/log/TLogController$1;)V

    sput-object v0, Lcom/taobao/tao/log/TLogController$a;->a:Lcom/taobao/tao/log/TLogController;

    return-void
.end method

.method static synthetic a()Lcom/taobao/tao/log/TLogController;
    .locals 1

    sget-object v0, Lcom/taobao/tao/log/TLogController$a;->a:Lcom/taobao/tao/log/TLogController;

    return-object v0
.end method
