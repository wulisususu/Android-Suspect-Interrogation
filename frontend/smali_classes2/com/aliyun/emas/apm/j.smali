.class public final enum Lcom/aliyun/emas/apm/j;
.super Ljava/lang/Enum;
.source "SourceFile"

# interfaces
.implements Ljava/util/concurrent/Executor;


# static fields
.field public static final enum a:Lcom/aliyun/emas/apm/j;

.field private static final b:Landroid/os/Handler;

.field private static final synthetic c:[Lcom/aliyun/emas/apm/j;


# direct methods
.method static constructor <clinit>()V
    .locals 3

    .line 1
    new-instance v0, Lcom/aliyun/emas/apm/j;

    const-string v1, "INSTANCE"

    const/4 v2, 0x0

    invoke-direct {v0, v1, v2}, Lcom/aliyun/emas/apm/j;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/aliyun/emas/apm/j;->a:Lcom/aliyun/emas/apm/j;

    .line 2
    invoke-static {}, Lcom/aliyun/emas/apm/j;->a()[Lcom/aliyun/emas/apm/j;

    move-result-object v0

    sput-object v0, Lcom/aliyun/emas/apm/j;->c:[Lcom/aliyun/emas/apm/j;

    .line 7
    new-instance v0, Landroid/os/Handler;

    invoke-static {}, Landroid/os/Looper;->getMainLooper()Landroid/os/Looper;

    move-result-object v1

    invoke-direct {v0, v1}, Landroid/os/Handler;-><init>(Landroid/os/Looper;)V

    sput-object v0, Lcom/aliyun/emas/apm/j;->b:Landroid/os/Handler;

    return-void
.end method

.method private constructor <init>(Ljava/lang/String;I)V
    .locals 0

    .line 1
    invoke-direct {p0, p1, p2}, Ljava/lang/Enum;-><init>(Ljava/lang/String;I)V

    return-void
.end method

.method private static synthetic a()[Lcom/aliyun/emas/apm/j;
    .locals 1

    sget-object v0, Lcom/aliyun/emas/apm/j;->a:Lcom/aliyun/emas/apm/j;

    filled-new-array {v0}, [Lcom/aliyun/emas/apm/j;

    move-result-object v0

    return-object v0
.end method

.method public static valueOf(Ljava/lang/String;)Lcom/aliyun/emas/apm/j;
    .locals 1

    const-class v0, Lcom/aliyun/emas/apm/j;

    .line 1
    invoke-static {v0, p0}, Ljava/lang/Enum;->valueOf(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/Enum;

    move-result-object p0

    check-cast p0, Lcom/aliyun/emas/apm/j;

    return-object p0
.end method

.method public static values()[Lcom/aliyun/emas/apm/j;
    .locals 1

    sget-object v0, Lcom/aliyun/emas/apm/j;->c:[Lcom/aliyun/emas/apm/j;

    .line 1
    invoke-virtual {v0}, [Lcom/aliyun/emas/apm/j;->clone()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Lcom/aliyun/emas/apm/j;

    return-object v0
.end method


# virtual methods
.method public execute(Ljava/lang/Runnable;)V
    .locals 1

    sget-object v0, Lcom/aliyun/emas/apm/j;->b:Landroid/os/Handler;

    .line 1
    invoke-virtual {v0, p1}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    return-void
.end method
