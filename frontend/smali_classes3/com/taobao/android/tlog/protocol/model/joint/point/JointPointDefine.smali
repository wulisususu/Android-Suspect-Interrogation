.class public final enum Lcom/taobao/android/tlog/protocol/model/joint/point/JointPointDefine;
.super Ljava/lang/Enum;
.source "JointPointDefine.java"


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Enum<",
        "Lcom/taobao/android/tlog/protocol/model/joint/point/JointPointDefine;",
        ">;"
    }
.end annotation


# static fields
.field private static final synthetic $VALUES:[Lcom/taobao/android/tlog/protocol/model/joint/point/JointPointDefine;

.field public static final enum BACKGROUND:Lcom/taobao/android/tlog/protocol/model/joint/point/JointPointDefine;

.field public static final enum CUSTOM_JOINT_POINT:Lcom/taobao/android/tlog/protocol/model/joint/point/JointPointDefine;

.field public static final enum FOREGROUND:Lcom/taobao/android/tlog/protocol/model/joint/point/JointPointDefine;

.field public static final enum LIFECYCLE:Lcom/taobao/android/tlog/protocol/model/joint/point/JointPointDefine;

.field public static final enum NOTIFICATION:Lcom/taobao/android/tlog/protocol/model/joint/point/JointPointDefine;

.field public static final enum STARTUP:Lcom/taobao/android/tlog/protocol/model/joint/point/JointPointDefine;

.field public static final enum TIMER:Lcom/taobao/android/tlog/protocol/model/joint/point/JointPointDefine;


# instance fields
.field private jointPointClass:Ljava/lang/Class;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/lang/Class<",
            "+",
            "Lcom/taobao/android/tlog/protocol/model/joint/point/JointPoint;",
            ">;"
        }
    .end annotation
.end field

.field private jointPointType:Ljava/lang/String;


# direct methods
.method static constructor <clinit>()V
    .locals 11

    .line 12
    new-instance v0, Lcom/taobao/android/tlog/protocol/model/joint/point/JointPointDefine;

    const-string v1, "lifecycle"

    const-class v2, Lcom/taobao/android/tlog/protocol/model/joint/point/LifecycleJointPoint;

    const-string v3, "LIFECYCLE"

    const/4 v4, 0x0

    invoke-direct {v0, v3, v4, v1, v2}, Lcom/taobao/android/tlog/protocol/model/joint/point/JointPointDefine;-><init>(Ljava/lang/String;ILjava/lang/String;Ljava/lang/Class;)V

    sput-object v0, Lcom/taobao/android/tlog/protocol/model/joint/point/JointPointDefine;->LIFECYCLE:Lcom/taobao/android/tlog/protocol/model/joint/point/JointPointDefine;

    .line 13
    new-instance v1, Lcom/taobao/android/tlog/protocol/model/joint/point/JointPointDefine;

    const-string v2, "notification"

    const-class v3, Lcom/taobao/android/tlog/protocol/model/joint/point/NotificationJointPoint;

    const-string v4, "NOTIFICATION"

    const/4 v5, 0x1

    invoke-direct {v1, v4, v5, v2, v3}, Lcom/taobao/android/tlog/protocol/model/joint/point/JointPointDefine;-><init>(Ljava/lang/String;ILjava/lang/String;Ljava/lang/Class;)V

    sput-object v1, Lcom/taobao/android/tlog/protocol/model/joint/point/JointPointDefine;->NOTIFICATION:Lcom/taobao/android/tlog/protocol/model/joint/point/JointPointDefine;

    .line 14
    new-instance v2, Lcom/taobao/android/tlog/protocol/model/joint/point/JointPointDefine;

    const-string v3, "startup"

    const-class v4, Lcom/taobao/android/tlog/protocol/model/joint/point/StartupJointPoint;

    const-string v5, "STARTUP"

    const/4 v6, 0x2

    invoke-direct {v2, v5, v6, v3, v4}, Lcom/taobao/android/tlog/protocol/model/joint/point/JointPointDefine;-><init>(Ljava/lang/String;ILjava/lang/String;Ljava/lang/Class;)V

    sput-object v2, Lcom/taobao/android/tlog/protocol/model/joint/point/JointPointDefine;->STARTUP:Lcom/taobao/android/tlog/protocol/model/joint/point/JointPointDefine;

    .line 15
    new-instance v3, Lcom/taobao/android/tlog/protocol/model/joint/point/JointPointDefine;

    const-string v4, "timer"

    const-class v5, Lcom/taobao/android/tlog/protocol/model/joint/point/TimerJointPoint;

    const-string v6, "TIMER"

    const/4 v7, 0x3

    invoke-direct {v3, v6, v7, v4, v5}, Lcom/taobao/android/tlog/protocol/model/joint/point/JointPointDefine;-><init>(Ljava/lang/String;ILjava/lang/String;Ljava/lang/Class;)V

    sput-object v3, Lcom/taobao/android/tlog/protocol/model/joint/point/JointPointDefine;->TIMER:Lcom/taobao/android/tlog/protocol/model/joint/point/JointPointDefine;

    .line 16
    new-instance v4, Lcom/taobao/android/tlog/protocol/model/joint/point/JointPointDefine;

    const-string v5, "event"

    const-class v6, Lcom/taobao/android/tlog/protocol/model/joint/point/EventJointPoint;

    const-string v7, "CUSTOM_JOINT_POINT"

    const/4 v8, 0x4

    invoke-direct {v4, v7, v8, v5, v6}, Lcom/taobao/android/tlog/protocol/model/joint/point/JointPointDefine;-><init>(Ljava/lang/String;ILjava/lang/String;Ljava/lang/Class;)V

    sput-object v4, Lcom/taobao/android/tlog/protocol/model/joint/point/JointPointDefine;->CUSTOM_JOINT_POINT:Lcom/taobao/android/tlog/protocol/model/joint/point/JointPointDefine;

    .line 17
    new-instance v5, Lcom/taobao/android/tlog/protocol/model/joint/point/JointPointDefine;

    const-string v6, "background"

    const-class v7, Lcom/taobao/android/tlog/protocol/model/joint/point/BackgroundJointPoint;

    const-string v8, "BACKGROUND"

    const/4 v9, 0x5

    invoke-direct {v5, v8, v9, v6, v7}, Lcom/taobao/android/tlog/protocol/model/joint/point/JointPointDefine;-><init>(Ljava/lang/String;ILjava/lang/String;Ljava/lang/Class;)V

    sput-object v5, Lcom/taobao/android/tlog/protocol/model/joint/point/JointPointDefine;->BACKGROUND:Lcom/taobao/android/tlog/protocol/model/joint/point/JointPointDefine;

    .line 18
    new-instance v6, Lcom/taobao/android/tlog/protocol/model/joint/point/JointPointDefine;

    const-string v7, "foreground"

    const-class v8, Lcom/taobao/android/tlog/protocol/model/joint/point/ForegroundJointPoint;

    const-string v9, "FOREGROUND"

    const/4 v10, 0x6

    invoke-direct {v6, v9, v10, v7, v8}, Lcom/taobao/android/tlog/protocol/model/joint/point/JointPointDefine;-><init>(Ljava/lang/String;ILjava/lang/String;Ljava/lang/Class;)V

    sput-object v6, Lcom/taobao/android/tlog/protocol/model/joint/point/JointPointDefine;->FOREGROUND:Lcom/taobao/android/tlog/protocol/model/joint/point/JointPointDefine;

    filled-new-array/range {v0 .. v6}, [Lcom/taobao/android/tlog/protocol/model/joint/point/JointPointDefine;

    move-result-object v0

    sput-object v0, Lcom/taobao/android/tlog/protocol/model/joint/point/JointPointDefine;->$VALUES:[Lcom/taobao/android/tlog/protocol/model/joint/point/JointPointDefine;

    return-void
.end method

.method private constructor <init>(Ljava/lang/String;ILjava/lang/String;Ljava/lang/Class;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/lang/Class<",
            "+",
            "Lcom/taobao/android/tlog/protocol/model/joint/point/JointPoint;",
            ">;)V"
        }
    .end annotation

    .line 23
    invoke-direct {p0, p1, p2}, Ljava/lang/Enum;-><init>(Ljava/lang/String;I)V

    iput-object p3, p0, Lcom/taobao/android/tlog/protocol/model/joint/point/JointPointDefine;->jointPointType:Ljava/lang/String;

    iput-object p4, p0, Lcom/taobao/android/tlog/protocol/model/joint/point/JointPointDefine;->jointPointClass:Ljava/lang/Class;

    return-void
.end method

.method public static fromName(Ljava/lang/String;)Lcom/taobao/android/tlog/protocol/model/joint/point/JointPointDefine;
    .locals 5

    .line 38
    invoke-static {}, Lcom/taobao/android/tlog/protocol/model/joint/point/JointPointDefine;->values()[Lcom/taobao/android/tlog/protocol/model/joint/point/JointPointDefine;

    move-result-object v0

    array-length v1, v0

    const/4 v2, 0x0

    :goto_0
    if-ge v2, v1, :cond_1

    aget-object v3, v0, v2

    .line 39
    iget-object v4, v3, Lcom/taobao/android/tlog/protocol/model/joint/point/JointPointDefine;->jointPointType:Ljava/lang/String;

    invoke-virtual {v4, p0}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v4

    if-eqz v4, :cond_0

    return-object v3

    :cond_0
    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    :cond_1
    const/4 p0, 0x0

    return-object p0
.end method

.method public static valueOf(Ljava/lang/String;)Lcom/taobao/android/tlog/protocol/model/joint/point/JointPointDefine;
    .locals 1

    const-class v0, Lcom/taobao/android/tlog/protocol/model/joint/point/JointPointDefine;

    .line 10
    invoke-static {v0, p0}, Ljava/lang/Enum;->valueOf(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/Enum;

    move-result-object p0

    check-cast p0, Lcom/taobao/android/tlog/protocol/model/joint/point/JointPointDefine;

    return-object p0
.end method

.method public static values()[Lcom/taobao/android/tlog/protocol/model/joint/point/JointPointDefine;
    .locals 1

    sget-object v0, Lcom/taobao/android/tlog/protocol/model/joint/point/JointPointDefine;->$VALUES:[Lcom/taobao/android/tlog/protocol/model/joint/point/JointPointDefine;

    .line 10
    invoke-virtual {v0}, [Lcom/taobao/android/tlog/protocol/model/joint/point/JointPointDefine;->clone()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Lcom/taobao/android/tlog/protocol/model/joint/point/JointPointDefine;

    return-object v0
.end method


# virtual methods
.method public getJointPointClass()Ljava/lang/Class;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/lang/Class<",
            "+",
            "Lcom/taobao/android/tlog/protocol/model/joint/point/JointPoint;",
            ">;"
        }
    .end annotation

    iget-object v0, p0, Lcom/taobao/android/tlog/protocol/model/joint/point/JointPointDefine;->jointPointClass:Ljava/lang/Class;

    return-object v0
.end method

.method public toString()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lcom/taobao/android/tlog/protocol/model/joint/point/JointPointDefine;->jointPointType:Ljava/lang/String;

    return-object v0
.end method
