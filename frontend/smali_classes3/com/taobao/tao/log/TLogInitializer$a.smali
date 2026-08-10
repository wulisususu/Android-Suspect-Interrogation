.class Lcom/taobao/tao/log/TLogInitializer$a;
.super Ljava/lang/Object;
.source "TLogInitializer.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/taobao/tao/log/TLogInitializer;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0xa
    name = "a"
.end annotation


# static fields
.field private static final a:Lcom/taobao/tao/log/TLogInitializer;


# direct methods
.method static constructor <clinit>()V
    .locals 2

    .line 105
    new-instance v0, Lcom/taobao/tao/log/TLogInitializer;

    const/4 v1, 0x0

    invoke-direct {v0, v1}, Lcom/taobao/tao/log/TLogInitializer;-><init>(Lcom/taobao/tao/log/TLogInitializer$1;)V

    sput-object v0, Lcom/taobao/tao/log/TLogInitializer$a;->a:Lcom/taobao/tao/log/TLogInitializer;

    return-void
.end method

.method static synthetic a()Lcom/taobao/tao/log/TLogInitializer;
    .locals 1

    sget-object v0, Lcom/taobao/tao/log/TLogInitializer$a;->a:Lcom/taobao/tao/log/TLogInitializer;

    return-object v0
.end method
