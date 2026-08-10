.class abstract Lcom/aliyun/emas/apm/f$b;
.super Ljava/lang/Object;
.source "SourceFile"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/aliyun/emas/apm/f;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0xa
    name = "b"
.end annotation


# static fields
.field private static a:Lcom/aliyun/emas/apm/f;


# direct methods
.method static constructor <clinit>()V
    .locals 2

    .line 1
    new-instance v0, Lcom/aliyun/emas/apm/f;

    const/4 v1, 0x0

    invoke-direct {v0, v1}, Lcom/aliyun/emas/apm/f;-><init>(Lcom/aliyun/emas/apm/f$a;)V

    sput-object v0, Lcom/aliyun/emas/apm/f$b;->a:Lcom/aliyun/emas/apm/f;

    return-void
.end method

.method static synthetic a()Lcom/aliyun/emas/apm/f;
    .locals 1

    sget-object v0, Lcom/aliyun/emas/apm/f$b;->a:Lcom/aliyun/emas/apm/f;

    return-object v0
.end method
