.class public Lcom/alibaba/ha/bizerrorreporter/BizErrorConstants;
.super Ljava/lang/Object;
.source "BizErrorConstants.java"


# static fields
.field public static final EVENTID_61005:Ljava/lang/Integer;

.field public static final K10:I = 0x2800

.field public static final LOGTAG:Ljava/lang/String; = "MotuCrashAdapter"

.field public static final SEND_FLAG:Ljava/lang/String; = "MOTU_REPORTER_SDK_3.0.0_PRIVATE_COMPRESS"

.field public static final exceptionArg1:Ljava/lang/String; = "exceptionArg1"

.field public static final exceptionArg2:Ljava/lang/String; = "exceptionArg2"

.field public static final exceptionArg3:Ljava/lang/String; = "exceptionArg3"

.field public static final exceptionCode:Ljava/lang/String; = "exceptionCode"

.field public static final exceptionDetail:Ljava/lang/String; = "exceptionDetail"

.field public static final exceptionId:Ljava/lang/String; = "exceptionId"

.field public static final exceptionVersion:Ljava/lang/String; = "exceptionVersion"


# direct methods
.method static constructor <clinit>()V
    .locals 1

    const v0, 0xee4d

    .line 13
    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v0

    sput-object v0, Lcom/alibaba/ha/bizerrorreporter/BizErrorConstants;->EVENTID_61005:Ljava/lang/Integer;

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .line 10
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method
