.class Lcom/taobao/tao/log/task/f$a;
.super Ljava/lang/Object;
.source "CommandManager.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/taobao/tao/log/task/f;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0xa
    name = "a"
.end annotation


# static fields
.field private static final a:Lcom/taobao/tao/log/task/f;


# direct methods
.method static constructor <clinit>()V
    .locals 2

    .line 31
    new-instance v0, Lcom/taobao/tao/log/task/f;

    const/4 v1, 0x0

    invoke-direct {v0, v1}, Lcom/taobao/tao/log/task/f;-><init>(Lcom/taobao/tao/log/task/f$1;)V

    sput-object v0, Lcom/taobao/tao/log/task/f$a;->a:Lcom/taobao/tao/log/task/f;

    return-void
.end method

.method static synthetic b()Lcom/taobao/tao/log/task/f;
    .locals 1

    sget-object v0, Lcom/taobao/tao/log/task/f$a;->a:Lcom/taobao/tao/log/task/f;

    return-object v0
.end method
