.class Lcom/ali/alihadeviceevaluator/AliHAHardware$SingleHolder;
.super Ljava/lang/Object;
.source "AliHAHardware.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/ali/alihadeviceevaluator/AliHAHardware;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0xa
    name = "SingleHolder"
.end annotation


# static fields
.field private static mInstance:Lcom/ali/alihadeviceevaluator/AliHAHardware;


# direct methods
.method static constructor <clinit>()V
    .locals 2

    .line 23
    new-instance v0, Lcom/ali/alihadeviceevaluator/AliHAHardware;

    const/4 v1, 0x0

    invoke-direct {v0, v1}, Lcom/ali/alihadeviceevaluator/AliHAHardware;-><init>(Lcom/ali/alihadeviceevaluator/AliHAHardware$1;)V

    sput-object v0, Lcom/ali/alihadeviceevaluator/AliHAHardware$SingleHolder;->mInstance:Lcom/ali/alihadeviceevaluator/AliHAHardware;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .line 22
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static synthetic access$100()Lcom/ali/alihadeviceevaluator/AliHAHardware;
    .locals 1

    sget-object v0, Lcom/ali/alihadeviceevaluator/AliHAHardware$SingleHolder;->mInstance:Lcom/ali/alihadeviceevaluator/AliHAHardware;

    return-object v0
.end method
